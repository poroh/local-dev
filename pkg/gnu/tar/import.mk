# SPDX-License-Identifier: MIT
#
# Gnu tar package
#

gnu-tar-default-version := 1.35
gnu-tar-version ?= $(gnu-tar-default-version)

ifndef gnu-tar..included-$(gnu-tar-version)
gnu-tar..included-$(gnu-tar-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/libiconv/import.mk

define gnu-tar-descr
  .name      := gnu-tar-$(gnu-tar-version)
  .version   := $(gnu-tar-version)
  .repo-type := gnu
  .repo-name := tar
  .deps      := $(call gnu-sed.f-pkg) $(call gnu-libiconv.f-pkg)
  .makefile  := pkg/gnu/tar/build.mk
  .makefile-vars := libiconv-prefix=$(call gnu-libiconv.f-prefix)
  .build-sandbox := bash ln expr chmod rm ls sort printf cat cc \
                    grep mv uname mkdir cp touch tr awk id make ar ld \
                    sleep uniq hexdump wc basename
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-tar-descr)

gnu-tar.f-exec = $(call ldv-pkg.f-prefix,gnu-tar-$(if $1,$1,$(gnu-tar-default-version)))/bin/tar
gnu-tar.f-path = $(call ldv-pkg.f-prefix,gnu-tar-$(if $1,$1,$(gnu-tar-default-version)))/bin

endif

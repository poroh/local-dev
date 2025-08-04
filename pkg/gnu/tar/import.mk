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
include $(ldv-root)/ldv-c-toolchain.mk

include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/libiconv/import.mk

gnu-tar.configure-flags = \
        CPPFLAGS="-I$(call gnu-libiconv.f-prefix)/include" \
	CFLAGS="-O2" \
        LDFLAGS="-L$(call gnu-libiconv.f-prefix)/lib -liconv" \
        --disable-dependency-tracking \
        --disable-silent-rules \
        --with-libiconv-prefix=$(call gnu-libiconv.f-prefix) 

define gnu-tar-descr
  .name      := gnu-tar-$(gnu-tar-version)
  .version   := $(gnu-tar-version)
  .repo-type := gnu
  .repo-name := tar
  .deps      := $(call gnu-sed.f-pkg) $(call gnu-libiconv.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags='$(gnu-tar.configure-flags)'
  .build-sandbox := $(ldv-c-toolchain.tools) \
                    bash ln expr chmod rm ls sort printf cat \
                    grep mv uname mkdir cp touch tr awk id make  \
                    sleep uniq hexdump wc basename
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-tar-descr)

gnu-tar.f-exec = $(call ldv-pkg.f-prefix,gnu-tar-$(if $1,$1,$(gnu-tar-version)))/bin/tar
gnu-tar.f-path = $(call ldv-pkg.f-prefix,gnu-tar-$(if $1,$1,$(gnu-tar-version)))/bin

endif

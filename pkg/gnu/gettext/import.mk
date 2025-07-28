# SPDX-License-Identifier: MIT
#
# GNU gettext package
#

gnu-gettext-default-version := 0.26
gnu-gettext-version ?= $(gnu-gettext-default-version)

ifndef gnu-gettext..included-$(gnu-gettext-version)
gnu-gettext..included-$(gnu-gettext-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/libiconv/import.mk

define gnu-gettext-descr
  .name      := gnu-gettext-$(gnu-gettext-version)
  .version   := $(gnu-gettext-version)
  .repo-type := gnu
  .repo-name := gettext
  .deps      := $(call gnu-sed.f-pkg) $(call gnu-libiconv.f-pkg)
  .makefile  := pkg/gnu/gettext/build.mk
  .makefile-vars := libiconv-prefix=$(call gnu-libiconv.f-prefix)
  .build-sandbox := bash expr chmod rm ls cat sort mkdir \
                    date uname grep awk tr mv make basename cp find \
                    cc rmdir id touch xargs ln wc uniq ar nm sh gzip \
                    tar dirname
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-gettext-descr)

gnu-gettext.f-pkg = gnu-gettext-$(if $1,$1,$(gnu-gettext-version))
gnu-gettext.f-exec = $(call ldv-pkg.f-prefix,gnu-gettext-$(if $1,$1,$(gnu-gettext-version)))/bin/gettext
gnu-gettext.f-path = $(call ldv-pkg.f-prefix,gnu-gettext-$(if $1,$1,$(gnu-gettext-version)))/bin

endif

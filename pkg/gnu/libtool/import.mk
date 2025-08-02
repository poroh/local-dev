# SPDX-License-Identifier: MIT
#
# GNU libtool package
#

gnu-libtool-default-version := 2.5.4
gnu-libtool-version ?= $(gnu-libtool-default-version)

ifndef gnu-libtool..included-$(gnu-libtool-version)
gnu-libtool..included-$(gnu-libtool-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/m4/import.mk

gnu-libtool.configure-flags = \
   CFLAGS="-O2 -Wno-compound-token-split-by-macro -Wno-constant-logical-operand" \
   --disable-dependency-tracking \
   --disable-silent-rules \
   --disable-ltdl-install

define gnu-libtool-descr
  .name      := gnu-libtool-$(gnu-libtool-version)
  .version   := $(gnu-libtool-version)
  .repo-type := gnu
  .repo-name := libtool
  .deps      := $(call gnu-m4.f-pkg) $(call gnu-sed.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags='$(gnu-libtool.configure-flags)'
  .build-sandbox := bash expr chmod rm ls cat make sort \
                    xargs echo mkdir date uname cc mv grep awk \
                    tr wc cp ar sleep rmdir env ln find ld basename \
                    dirname
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-libtool-descr)

gnu-libtool.f-pkg = gnu-libtool-$(if $1,$1,$(gnu-libtool-version))
gnu-libtool.f-exec = $(call ldv-pkg.f-prefix,gnu-libtool-$(if $1,$1,$(gnu-libtool-version)))/bin/libtool
gnu-libtool.f-path = $(call ldv-pkg.f-prefix,gnu-libtool-$(if $1,$1,$(gnu-libtool-version)))/bin

endif

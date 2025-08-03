# SPDX-License-Identifier: MIT
#
# GNU autoconf package
#

gnu-autoconf-default-version := 2.72
gnu-autoconf-version ?= $(gnu-autoconf-default-version)

ifndef gnu-autoconf..included-$(gnu-autoconf-version)
gnu-autoconf..included-$(gnu-autoconf-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/m4/import.mk
include $(ldv-root)/pkg/github/perl/import.mk

gnu-autoconf.configure-flags ?= \
   CFLAGS="-O2 -Wno-compound-token-split-by-macro -Wno-constant-logical-operand" \
   --disable-dependency-tracking \
   --disable-silent-rules \
   --disable-ltdl-install

define gnu-autoconf-descr
  .name      := gnu-autoconf-$(gnu-autoconf-version)
  .version   := $(gnu-autoconf-version)
  .repo-type := gnu
  .repo-name := autoconf
  .deps      := $(call gnu-m4.f-pkg) $(call gnu-sed.f-pkg) $(call perl.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags='$(gnu-autoconf.configure-flags)'
  .build-sandbox := bash expr chmod rm ls cat sort mkdir \
                    date uname grep awk tr mv make basename cp \
                    touch
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-autoconf-descr)

gnu-autoconf.f-pkg = gnu-autoconf-$(if $1,$1,$(gnu-autoconf-version))
gnu-autoconf.f-exec = $(call ldv-pkg.f-prefix,gnu-autoconf-$(if $1,$1,$(gnu-autoconf-version)))/bin/autoconf
gnu-autoconf.f-path = $(call ldv-pkg.f-prefix,gnu-autoconf-$(if $1,$1,$(gnu-autoconf-version)))/bin

endif

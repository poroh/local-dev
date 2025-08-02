# SPDX-License-Identifier: MIT
#
# GNU readline package
#

gnu-readline-default-version := 8.3
gnu-readline-version ?= $(gnu-readline-default-version)

ifndef gnu-readline..included-$(gnu-readline-version)
gnu-readline..included-$(gnu-readline-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-tools.mk

include $(ldv-root)/pkg/gnu/ncurses/import.mk

gnu-readline.configure-flags = \
        CFLAGS="-O2 -Wno-parentheses $(call gnu-ncurses.f-cflags)" \
        LDFLAGS="$(call gnu-ncurses.f-ldflags)"

gnu-readline.make-env = \
     MFLAGS="$(call ldv-tools.f-get-j,$(MFLAGS))" \
     MAKEFLAGS="$(call ldv-tools.f-get-j,$(MAKEFLAGS))"

define gnu-readline-descr
  .name      := gnu-readline-$(gnu-readline-version)
  .version   := $(gnu-readline-version)
  .repo-type := gnu
  .repo-name := readline
  .deps      := $(call gnu-ncurses.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags='$(gnu-readline.configure-flags)' make-env='$(gnu-readline.make-env) '
  .build-sandbox := bash expr chmod rm ls cat make sort sed \
                    xargs echo mkdir date uname cc mv grep awk \
                    tr wc cp ar sleep rmdir env ln find ld basename \
                    dirname
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-readline-descr)

gnu-readline.f-pkg = gnu-readline-$(if $1,$1,$(gnu-readline-version))
gnu-readline.f-cflags = -I$(call ldv-pkg.f-prefix,gnu-readline-$(if $1,$1,$(gnu-readline-version)))/include
gnu-readline.f-ldflags = -L$(call ldv-pkg.f-prefix,gnu-readline-$(if $1,$1,$(gnu-readline-version)))/lib

endif

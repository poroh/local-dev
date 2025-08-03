# SPDX-License-Identifier: MIT
#
# GNU ncurses package
#

gnu-ncurses-default-version := 6.5
gnu-ncurses-version ?= $(gnu-ncurses-default-version)

ifndef gnu-ncurses..included-$(gnu-ncurses-version)
gnu-ncurses..included-$(gnu-ncurses-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

gnu-ncurses.configure-flags = \
   CFLAGS="-O2" \
   --without-ada \
   --without-cxx \
   --without-cxx-bindings \
   --without-manpages \
   --without-profile \
   --without-tests \
   --disable-widec

define gnu-ncurses-descr
  .name      := gnu-ncurses-$(gnu-ncurses-version)
  .version   := $(gnu-ncurses-version)
  .repo-type := gnu
  .repo-name := ncurses
  .deps      := 
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags='$(gnu-ncurses.configure-flags)'
  .build-sandbox := $(ldv-c-toolchain.tools) \
                    bash expr chmod rm ls cat make sort sed \
                    xargs echo mkdir date uname mv grep awk \
                    tr wc cp sleep rmdir env ln find basename \
                    dirname cut touch cmp head uniq strip
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-ncurses-descr)

gnu-ncurses.f-pkg = gnu-ncurses-$(if $1,$1,$(gnu-ncurses-version))
gnu-ncurses.f-ldflags = -L$(call ldv-pkg.f-prefix,gnu-ncurses-$(if $1,$1,$(gnu-ncurses-version)))/lib
gnu-ncurses.f-cflags = -I$(call ldv-pkg.f-prefix,gnu-ncurses-$(if $1,$1,$(gnu-ncurses-version)))/include

endif

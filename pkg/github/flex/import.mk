# SPDX-License-Identifier: MIT
#
# Flex package
#

flex-default-version := v2.6.4
flex-version ?= $(flex-default-version)

ifndef flex..included-$(flex-version)
flex..included-$(flex-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

gnu-autoconf-version := 2.65
gnu-automake-version := 1.18

include $(ldv-root)/pkg/gnu/libtool/import.mk
include $(ldv-root)/pkg/gnu/autoconf/import.mk
include $(ldv-root)/pkg/gnu/automake/import.mk
include $(ldv-root)/pkg/gnu/gettext/import.mk
include $(ldv-root)/pkg/gnu/m4/import.mk
include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/bison/import.mk

define flex-descr
  .name      := flex-$(flex-version)
  .version   := $(flex-version)
  .repo-type := github
  .repo-name := westes/flex
  .deps      := $(call gnu-libtool.f-pkg) $(call gnu-autoconf.f-pkg) \
                $(call gnu-automake.f-pkg) $(call gnu-gettext.f-pkg) \
                $(call gnu-m4.f-pkg) $(call gnu-sed.f-pkg) \
                $(call gnu-bison.f-pkg)
  .makefile  := pkg/github/flex/build.mk
  .makefile-vars := autoconf-bin=$(call gnu-autoconf.f-exec) automake-bin=$(call gnu-automake.f-exec)
  .build-sandbox := bash sh env which ln date cat touch grep wc \
                    mkdir gzip tar find rm mv sort cp expr chmod ls cc \
                    uname awk make
  .env-path  := bin
endef

$(call ldv-pkg-f-define,flex-descr)

flex.f-pkg = flex-$(if $1,$1,$(flex-version))
flex.f-exec = $(call ldv-pkg.f-prefix,flex-$(if $1,$1,$(flex-version)))/bin/flex
flex.f-path = $(call ldv-pkg.f-prefix,flex-$(if $1,$1,$(flex-version)))/bin

endif

# SPDX-License-Identifier: MIT
#
# GNU automake package
#

gnu-automake-default-version := 1.18
gnu-automake-version ?= $(gnu-automake-default-version)

ifndef gnu-automake..included-$(gnu-automake-version)
gnu-automake..included-$(gnu-automake-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/m4/import.mk
include $(ldv-root)/pkg/gnu/autoconf/import.mk
include $(ldv-root)/pkg/github/perl/import.mk

define gnu-automake-descr
  .name      := gnu-automake-$(gnu-automake-version)
  .version   := $(gnu-automake-version)
  .repo-type := gnu
  .repo-name := automake
  .deps      := $(call gnu-autoconf.f-pkg) $(call gnu-sed.f-pkg) $(call perl.f-pkg)
  .makefile  := pkg/gnu/automake/build.mk
  .makefile-vars :=
  .build-sandbox := bash expr chmod rm ls cat sort mkdir \
                    date uname grep awk tr mv make basename cp find
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-automake-descr)

gnu-automake.f-pkg = gnu-automake-$(if $1,$1,$(gnu-automake-version))
gnu-automake.f-exec = $(call ldv-pkg.f-prefix,gnu-automake-$(if $1,$1,$(gnu-automake-version)))/bin/automake
gnu-automake.f-path = $(call ldv-pkg.f-prefix,gnu-automake-$(if $1,$1,$(gnu-automake-version)))/bin

endif

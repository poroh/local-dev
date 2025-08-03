# SPDX-License-Identifier: MIT
#
# GNU help2man package
#

gnu-help2man-default-version := 1.43.3
gnu-help2man-version ?= $(gnu-help2man-default-version)

ifndef gnu-help2man..included-$(gnu-help2man-version)
gnu-help2man..included-$(gnu-help2man-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

include $(ldv-root)/pkg/github/perl/import.mk

gnu-help2man.configure-flags ?= \
   CFLAGS=-O2

define gnu-help2man-descr
  .name      := gnu-help2man-$(gnu-help2man-version)
  .version   := $(gnu-help2man-version)
  .repo-type := gnu
  .repo-name := help2man
  .deps      := $(call perl.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags=$(gnu-help2man.configure-flags)
  .build-sandbox := $(ldv-c-toolchain.tools) \
                    bash sed expr rm ls cat sort grep mv chmod \
                    mkdir tr awk make basename cp
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-help2man-descr)

gnu-help2man.f-pkg = gnu-help2man-$(if $1,$1,$(gnu-help2man-version))
gnu-help2man.f-exec = $(call ldv-pkg.f-prefix,gnu-help2man-$(if $1,$1,$(gnu-help2man-version)))/bin/help2man
gnu-help2man.f-path = $(call ldv-pkg.f-prefix,gnu-help2man-$(if $1,$1,$(gnu-help2man-version)))/bin

endif

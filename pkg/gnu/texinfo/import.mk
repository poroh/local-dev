# SPDX-License-Identifier: MIT
#
# GNU texinfo package
#

gnu-texinfo-default-version := 7.2
gnu-texinfo-version ?= $(gnu-texinfo-default-version)

ifndef gnu-texinfo..included-$(gnu-texinfo-version)
gnu-texinfo..included-$(gnu-texinfo-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

include $(ldv-root)/pkg/github/perl/import.mk

gnu-texinfo.configure-flags ?= \
   CFLAGS="-O2" \
   --disable-dependency-tracking

define gnu-texinfo-descr
  .name      := gnu-texinfo-$(gnu-texinfo-version)
  .version   := $(gnu-texinfo-version)
  .repo-type := gnu
  .repo-name := texinfo
  .deps      :=  $(call perl.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags='$(gnu-texinfo.configure-flags)'
  .build-sandbox := $(ldv-c-toolchain.tools) \
                    sed expr rm ls mv cp mkdir touch cat sort chmod \
                    tr awk uniq grep uname sleep make bash \
                    basename rmdir ln id xargs wc dirname
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-texinfo-descr)

gnu-texinfo.f-pkg = gnu-texinfo-$(if $1,$1,$(gnu-texinfo-version))
gnu-texinfo.f-exec = $(call ldv-pkg.f-prefix,gnu-texinfo-$(if $1,$1,$(gnu-texinfo-version)))/bin/texinfo
gnu-texinfo.f-path = $(call ldv-pkg.f-prefix,gnu-texinfo-$(if $1,$1,$(gnu-texinfo-version)))/bin

endif

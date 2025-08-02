# SPDX-License-Identifier: MIT
#
# GNU m4 package
#

gnu-m4-default-version := 1.4.20
gnu-m4-version ?= $(gnu-m4-default-version)

ifndef gnu-m4..included-$(gnu-m4-version)
gnu-m4..included-$(gnu-m4-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

include $(ldv-root)/pkg/gnu/sed/import.mk

gnu-m4.configure-flags ?= \
    CFLAGS="-O3"

define gnu-m4-descr
  .name      := gnu-m4-$(gnu-m4-version)
  .version   := $(gnu-m4-version)
  .repo-type := gnu
  .repo-name := m4
  .deps      := $(call gnu-sed.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags='$(gnu-m4.configure-flags)'
  .build-sandbox := bash expr chmod rm ls sort cat printf \
                    cc mv grep cp mkdir sleep date uname make \
                    tr touch wc uniq awk xargs ln ar cmp basename
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-m4-descr)

gnu-m4.f-pkg = gnu-m4-$(if $1,$1,$(gnu-m4-version))
gnu-m4.f-exec = $(call ldv-pkg.f-m4,gnu-m4-$(if $1,$1,$(gnu-m4-version)))/bin/m4
gnu-m4.f-path = $(call ldv-pkg.f-prefix,gnu-m4-$(if $1,$1,$(gnu-m4-version)))/bin

endif

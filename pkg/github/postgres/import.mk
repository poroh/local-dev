# SPDX-License-Identifier: MIT
#
# Postgres package
#

postgres-default-version := REL_17_5
postgres-version ?= $(postgres-default-version)

ifndef postgres..included-$(postgres-version)
postgres..included-$(postgres-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-tools.mk
include $(ldv-root)/ldv-c-toolchain.mk

include $(ldv-root)/pkg/gnu/readline/import.mk
include $(ldv-root)/pkg/zlib/import.mk

postgres..deps := $(call gnu-readline.f-pkg) \
                  $(call zlib.f-pkg)

postgres.configure-flags = \
     CFLAGS="-O2 $(call gnu-readline.f-cflags) $(call zlib.f-cflags)" \
     LDFLAGS="$(call gnu-readline.f-ldflags) $(call zlib.f-ldflags)" \
     --without-icu \

postgres.make-env = \
     MFLAGS="$(call ldv-tools.f-get-j,$(MFLAGS))" \
     MAKEFLAGS="$(call ldv-tools.f-get-j,$(MAKEFLAGS))" \
     MAKELEVEL=

define postgres-descr
  .name      := postgres-$(postgres-version)
  .version   := $(postgres-version)
  .repo-type := github
  .repo-name := postgres/postgres
  .deps      := $(postgres..deps)
  .makefile  := build/configure-build.mk
  .makefile-vars  := configure-flags='$(postgres.configure-flags)' make-env='$(postgres.make-env) '
  .tools     := $(ldv-c-toolchain.tools) \
                bash sed expr rm ls cat sort uname grep mv \
                awk make chmod mkdir cp tr touch sh wc \
                basename bison perl flex
  .env-path  := bin
endef

$(call ldv-pkg-f-define,postgres-descr)

postgres.f-dep = $(call ldv-pkg.f-dep,postgres-$(if $1,$1,$(postgres-version)))

endif

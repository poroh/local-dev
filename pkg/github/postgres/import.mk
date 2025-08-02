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

include $(ldv-root)/pkg/gnu/bison/import.mk
include $(ldv-root)/pkg/gnu/readline/import.mk
include $(ldv-root)/pkg/github/flex/import.mk
include $(ldv-root)/pkg/github/perl/import.mk

postgres.configure-flags = \
     CFLAGS="-O2 $(call gnu-readline.f-cflags) $(call gnu-readline.f-ldflags)" \
     LDLAGS="$(call gnu-readline.f-ldflags)" \
     --without-icu

define postgres-descr
  .name      := postgres-$(postgres-version)
  .version   := $(postgres-version)
  .repo-type := github
  .repo-name := postgres/postgres
  .deps      := $(call gnu-bison.f-pkg) $(call flex.f-pkg) \
                $(call perl.f-pkg) $(call gnu-readline.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars  := configure-flags='$(postgres.configure-flags)'
  .build-sandbox := bash sed expr rm ls cat sort uname cc grep mv \
                    awk
  .env-path  := bin
endef

$(call ldv-pkg-f-define,postgres-descr)

endif

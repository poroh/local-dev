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
include $(ldv-root)/pkg/kernel.org/e2fsprogs/libuuid.mk
include $(ldv-root)/pkg/github/openssl/import.mk

postgres..deps := $(call gnu-readline.f-pkg) \
                  $(call zlib.f-pkg) \
                  $(call e2fsprogs-libuuid.f-pkg) \
                  $(call openssl.f-pkg)

postgres..cpp-flags := $(call gnu-readline.f-cppflags) \
                       $(call zlib.f-cppflags) \
                       $(call e2fsprogs-libuuid.f-cppflags) \
                       $(call openssl.f-cppflags)

postgres..ld-flags := $(call gnu-readline.f-ldflags) \
                      $(call zlib.f-ldflags) \
                      $(call e2fsprogs-libuuid.f-ldflags) \
                      $(call openssl.f-ldflags)

postgres.configure-flags = \
     CPPFLAGS="-O2 $(postgres..c-flags)" \
     LDFLAGS="$(postgres..ld-flags)" \
     --without-icu \
     --with-uuid=e2fs \
     --with-openssl \
     --with-zlib

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

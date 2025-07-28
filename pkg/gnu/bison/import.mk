# SPDX-License-Identifier: MIT
#
# GNU bison package
#

gnu-bison-default-version := 3.8
gnu-bison-version ?= $(gnu-bison-default-version)

ifndef gnu-bison..included-$(gnu-bison-version)
gnu-bison..included-$(gnu-bison-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/m4/import.mk

define gnu-bison-descr
  .name      := gnu-bison-$(gnu-bison-version)
  .version   := $(gnu-bison-version)
  .repo-type := gnu
  .repo-name := bison
  .deps      := $(call gnu-sed.f-pkg) $(call gnu-m4.f-pkg)
  .makefile  := pkg/gnu/bison/build.mk
  .makefile-vars :=
  .build-sandbox := bash expr chmod rm ls sort cat printf \
                    cc mv grep cp mkdir sleep date uname \
                    tr touch awk uniq make env ar ln cmp basename
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-bison-descr)

gnu-bison.f-pkg = gnu-bison-$(if $1,$1,$(gnu-bison-version))
gnu-bison.f-exec = $(call ldv-pkg.f-prefix,gnu-bison-$(if $1,$1,$(gnu-bison-version)))/bin/bison
gnu-bison.f-path = $(call ldv-pkg.f-prefix,gnu-bison-$(if $1,$1,$(gnu-bison-version)))/bin

endif

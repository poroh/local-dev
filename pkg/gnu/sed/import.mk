# SPDX-License-Identifier: MIT
#
# GNU sed package
#

gnu-sed-default-version := 4.2.2
gnu-sed-version ?= $(gnu-sed-default-version)

ifndef gnu-sed..included-$(gnu-sed-version)
gnu-sed..included-$(gnu-sed-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

define gnu-sed-descr
  .name      := $(call gnu-sed.f-pkg,$(gnu-sed-version))
  .version   := $(gnu-sed-version)
  .repo-type := gnu
  .repo-name := sed
  .deps      :=
  .makefile  := pkg/gnu/sed/build.mk
  .build-sandbox := sed expr rm ls mv cp mkdir touch cat sort chmod \
                    tr awk uniq grep uname sleep make cc ld ar bash basename rmdir ln
  .env-path  := bin
endef

gnu-sed.f-pkg = gnu-sed-$(if $1,$1,$(gnu-sed-default-version))
gnu-sed.f-exec = $(call ldv-pkg.f-prefix,gnu-sed-$(if $1,$1,$(gnu-sed-default-version)))/bin/sed
gnu-sed.f-path = $(call ldv-pkg.f-prefix,gnu-sed-$(if $1,$1,$(gnu-sed-default-version)))/bin

$(call ldv-pkg-f-define,gnu-sed-descr)

endif

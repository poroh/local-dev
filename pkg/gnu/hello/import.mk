# SPDX-License-Identifier: MIT
#
# Gnu hello package
#

gnu-hello-default-version := 2.10
gnu-hello-version ?= $(gnu-hello-default-version)

ifndef gnu-hello..included-$(gnu-hello-version)
gnu-hello..included-$(gnu-hello-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

include $(ldv-root)/pkg/gnu/sed/import.mk

gnu-hello.configure-flags ?= \
    CFLAGS="-O2 -Wno-expansion-to-defined" \
    --disable-dependency-tracking \
    --without-libintl-prefix  \
    --without-libiconv-prefix


define gnu-hello-descr
  .name      := gnu-hello-$(gnu-hello-version)
  .version   := $(gnu-hello-version)
  .repo-type := gnu
  .repo-name := hello
  .deps      := $(call gnu-sed.f-pkg)
  .makefile  := pkg/gnu/hello/build.mk
  .makefile-vars := configure-flags='$(gnu-hello.configure-flags)'
  .build-sandbox := $(ldv-c-toolchain.tools) \
                    expr rm ls mv cp mkdir touch cat sort chmod \
                    tr awk uniq grep uname sleep make \
                    bash basename rmdir ln
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-hello-descr)

gnu-hello.f-exec = $(call ldv-pkg.f-prefix,gnu-hello-$(if $1,$1,$(gnu-hello-version)))/bin/hello
gnu-hello.f-path = $(call ldv-pkg.f-prefix,gnu-hello-$(if $1,$1,$(gnu-hello-version)))/bin

endif

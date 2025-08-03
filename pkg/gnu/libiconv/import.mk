# SPDX-License-Identifier: MIT
#
# Gnu hello package
#

gnu-libiconv-default-version := 1.18
gnu-libiconv-version ?= $(gnu-libiconv-default-version)

ifndef gnu-libiconv..included-$(gnu-libiconv-version)
gnu-libiconv..included-$(gnu-libiconv-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

include $(ldv-root)/pkg/gnu/sed/import.mk

gnu-libiconv.configure-flags ?= \
    CFLAGS="-O2 -Wno-parentheses-equality" \
    --disable-dependency-tracking \
    --without-libintl-prefix

define gnu-libiconv-descr
  .name      := gnu-libiconv-$(gnu-libiconv-version)
  .version   := $(gnu-libiconv-version)
  .repo-type := gnu
  .repo-name := libiconv
  .deps      := $(call gnu-sed.f-pkg)
  .makefile  := pkg/gnu/libiconv/build.mk
  .makefile-vars := configure-flags='$(gnu-libiconv.configure-flags)'
  .build-sandbox := expr rm ls mv cp mkdir touch cat sort chmod \
                    tr awk uniq grep uname sleep make cc as ld ar bash \
                    basename rmdir ln wc dirname xargs
  .env-path  := bin
endef

$(call ldv-pkg-f-define,gnu-libiconv-descr)

gnu-libiconv.f-pkg = gnu-libiconv-$(if $1,$1,$(gnu-libiconv-version))
gnu-libiconv.f-prefix = $(call ldv-pkg.f-prefix,$(call gnu-libiconv.f-pkg,$(if $1,$1,$(gnu-libiconv-version))))

endif

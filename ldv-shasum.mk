# SPDX-License-Identifier: MIT
#
# Sha sum routines
#

ifndef ldv-shasum--included
ldv-shasum--included := 1

include $(ldv-root)/ldv-bin.mk
$(call ldv-bin-f-required,sha256sum)
$(call ldv-bin-f-required,echo)
$(call ldv-bin-f-required,cut)

ldv-shasum-f-short = $(shell $(call ldv-bin-f-exec,echo) '$1' | $(call ldv-bin-f-exec,sha256sum) | $(call ldv-bin-f-exec,cut) -b 1-10)

endif

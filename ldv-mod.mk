# SPDX-License-Identifier: MIT
#
# Local development modules
#

ifndef ldv-mod..included
ldv-mod..included := 1

include $(ldv-root)/ldv-debug.mk

# ================================================================================
# Interface

# Define module with rules.
# $1 module name
# $2 rules variable name
define ldv-mod-provide
  $(eval $(call ldv-mod--define-vars,$1,$2))
endef

ldv-mod-define-rules = $(foreach m,$(ldv-mod--all-modules),$(if $(ldv-mod--rules-$m),$(eval $(call ldv-mod--define-rules,$m))))

# ================================================================================
# Implementation

define ldv-mod--define-vars
  ldv-mod--all-modules += $1
  ldv-mod--rules-$1 = $2
endef

define ldv-mod--define-rules
  $(call ldv-debug.f-info,ldv-mod: define rules of $1)
  $($(ldv-mod--rules-$1))
endef

endif

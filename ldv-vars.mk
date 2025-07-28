# SPDX-License-Identifier: MIT
#
# Routines related to Makefile variables
#

ifndef ldv-vars..included
ldv-vars..included := 1

ldv-vars.debug ?=
ldv-vars.f-must-not-empty = $(if $($1),$(call ldv-vars.f-debug-print,$1),$(error $(if $2,$2,$1 must be defined)))
ldv-vars.f-debug-print = $(if $(ldv-vars.debug),$(info $1 = $($1)))
ldv-vars.f-get = $(if $($1),$($1),$(error $(if $2,$2,$1 not defined or empty)))

ldv-vars.f-store = $(foreach v,$2,$(call ldv-vars..f-store-one,$1,$v))
ldv-vars.f-restore = $(foreach v,$2,$(call ldv-vars..f-restore-one,$1,$v))
ldv-vars.f-clear = $(foreach v,$1,$(eval undefine $v))

define ldv-vars..f-store-one
$(eval
  ifdef $2
    ldv-vars..stored-var.$1.$2 := $$($$2)
  endif
)
endef

define ldv-vars..f-restore-one
$(eval
  ifdef ldv-vars..stored-var.$1.$2
    $2 := $$(ldv-vars..stored-var.$1.$2)
    undefine ldv-vars..stored-var.$1.$2
  endif
)
endef

endif # ifndef ldv-vars..included

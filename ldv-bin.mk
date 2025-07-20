# SPDX-License-Identifier: MIT
#
# Routintes related to executables
#

ifndef ldv-bin--included
ldv-bin--included := 1

include $(ldv-root)/ldv-vars.mk

$(if $(shell which -v),,$(error which must be installed))

# ldv-bin-f-required: Check that $1 program installed and define variable with full path
# $1 - program name
# Example:
# $(call ldv-bin-f-required,sha256sum)
#
define ldv-bin-f-required
$(eval $(call ldv-bin-f--required-1,$1))
$(eval $(call ldv-bin-f--required-2,$1))
endef

ldv-bin-f-exec = $(if $(ldv-bin--path-$1),$(ldv-bin--path-$1),$(error Binary for $1 is not defined))

ldv-bin-f-seal = $(eval $(call ldv-bin--seal))

define ldv-bin-f--required-1
ldv-bin--path-$1 := $(shell which $1)
endef

define ldv-bin-f--required-2
$(call ldv-vars-f-must-not-empty,ldv-bin--path-$1)
ldv-bin--all-bin += $1
endef

define ldv-bin--seal
$(info Executable are sealed. No more execs from PATH)
export PATH :=
endef

endif # ifndef ldv-bin--included

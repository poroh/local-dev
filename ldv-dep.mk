# SPDX-License-Identifier: MIT
#
# Define dependencies in local development
#
# Variables:
# ldv-dep-path-base: path where dep files will be created
#

ifndef ldv-dep--included
ldv-dep--included := 1

include $(ldv-root)/ldv-vars.mk
include $(ldv-root)/ldv-shasum.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-mod.mk

$(call ldv-vars-f-must-not-empty,ldv-dep-base-path)
$(call ldv-bin-f-required,touch)
$(call ldv-bin-f-required,mkdir)

# Define dependency
# $1 name
# $2 non-ldv dependencies, like version files shasum etc.
# $3 space-sparated ldv dependencies
define ldv-dep-define
$(eval $(call ldv-dep--define-vars-shasums,$1,$2,$3))
$(eval $(call ldv-dep--define-vars-2,$1))
endef

define ldv-dep--define-vars-shasums
$(foreach d,$3,$(call ldv-vars-f-must-not-empty,ldv-dep--$(d),Dependency $d is not defined))
ldv-dep--shasum-dep-$1 := $(call ldv-shasum-f-short,$2 $(foreach d,$3,$(ldv-dep--shasum-dep-$(d))))
ldv-dep--ldv-deps-$1 := $3
endef

define ldv-dep--define-vars-2
ldv-dep--$1 := $(ldv-dep-base-path)/$1.$(ldv-dep--shasum-dep-$1).ldv-dep
ldv-dep--all += $1
endef

ldv-dep-all = $(foreach d,$(ldv-dep--all),$(ldv-dep--$d))

ldv-dep--root := $(ldv-dep-base-path)/.dir-dep

# Target and prerequisites for dependency. Pattern here is:
# $(call ldv-dep-f-target,something): $(call ldv-dep-f-prereq,something)
# 	your-rules
#       $(ldv-dep-touch)
ldv-dep-f-target = $(ldv-dep--$1)
ldv-dep-f-prereq = $(ldv-dep--root) $(foreach d,$(ldv-dep--ldv-deps-$1),$(ldv-dep--$d))
ldv-dep-touch = $(call ldv-bin-f-exec,touch) $@

endif

define ldv-dep-f-rules
$(ldv-dep--root):
	$(call ldv-bin-f-exec,mkdir) -p $(ldv-dep-base-path)
	$(call ldv-bin-f-exec,touch) $$@

$(foreach d,$(filter-out $(ldv-dep-all),$(wildcard $(ldv-dep-base-path)/*.ldv-dep)),$(shell $(call ldv-bin-f-exec,rm) $d))

endef

$(call ldv-mod-provide,ldv-dep,ldv-dep-f-rules)

# SPDX-License-Identifier: MIT
#
# Define dependencies in local development
#

ifndef ldv-dep..included
ldv-dep..included := 1

include $(ldv-root)/ldv-vars.mk
include $(ldv-root)/ldv-shasum.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-mod.mk

$(call ldv-vars.f-must-not-empty,ldv-base-path)
$(call ldv-bin.f-required,touch)
$(call ldv-bin.f-required,mkdir)
$(call ldv-bin.f-required,rm)

ldv-dep.base-path = $(ldv-base-path)/dep
ldv-dep.keep-old ?= 1

# ================================================================================
# Interface

# Define dependency
# $1 name
# $2 non-ldv dependencies, like version files shasum etc.
# $3 space-sparated ldv dependencies
define ldv-dep.f-define
  $(eval $(call ldv-dep..f-define-vars-shasums,$1,$2,$3))
  $(eval $(call ldv-dep..f-define-vars-2,$1))
endef

# All defined dependencies
ldv-dep.all = $(foreach d,$(ldv-dep..all),$(ldv-dep..[$d].file))

# Target and prerequisites for dependency. Pattern here is:
# $(call ldv-dep.f-target,something): $(call ldv-dep.f-prereq,something)
# 	your-rules
#       $(call ldv-dep.f-touch,$@)
ldv-dep.f-target = $(call ldv-vars.f-get,ldv-dep..[$1].file,Dep $1 is not defined)
ldv-dep.f-prereq = $(ldv-dep..root) $(foreach d,$(ldv-dep..[$1].ldv-deps),$(ldv-dep..[$d].file))
ldv-dep.f-touch = $(call ldv-bin.f-exec,touch) $1

ldv-dep.f-sha = $(call ldv-vars.f-get,ldv-dep..[$1].shasum-dep,Dep $1 is not defined)

# ================================================================================
# Implementation

define ldv-dep..f-define-vars-shasums
  $(foreach d,$3,$(call ldv-vars.f-must-not-empty,ldv-dep..[$d].file,Dependency $d is not defined))
  ldv-dep..[$1].shasum-dep := $(call ldv-shasum-f-short,$2 $(foreach d,$3,$(ldv-dep..[$d].shasum-dep)))
  ldv-dep..[$1].ldv-deps := $3
endef

define ldv-dep..f-define-vars-2
  ldv-dep..[$1].file := $(ldv-dep.base-path)/$1.$(ldv-dep..[$1].shasum-dep).ldv-dep
  ldv-dep..all += $1
endef

ldv-dep..root := $(ldv-dep.base-path)/.dir-dep

define ldv-dep..f-rules
$(ldv-dep..root):
	$(call ldv-bin.f-exec,mkdir) -p $(ldv-dep.base-path)
	$(call ldv-bin.f-exec,touch) $$@


$(if $(ldv-dep.keep-old),,$(foreach d,$(filter-out $(ldv-dep.all),$(wildcard $(ldv-dep.base-path)/*.ldv-dep)),$(shell $(call ldv-bin.f-exec,rm) $d)))

endef

$(call ldv-mod-provide,ldv-dep,ldv-dep..f-rules)

endif

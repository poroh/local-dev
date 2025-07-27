# SPDX-License-Identifier: MIT
#
# Sandbox
#

ifndef ldv-sandbox..included
ldv-sandbox..included := 1

include $(ldv-root)/ldv-dep.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-tools.mk

# ================================================================================
# Interface

# Define sandbox with name $1
# with system executables $2
define ldv-sandbox.f-define
  $(eval $(call ldv-sandbox..f-define-dep,$1,$2))
endef

define ldv-sandbox..f-define-dep
  $(foreach bin,$2,$(call ldv-bin.f-required,$(bin)))
  $(call ldv-dep.f-define,ldv-sandbox..dep-$1,$2,)
  ldv-sandbox..bins-$1 = $2
  ldv-sandbox..all += $1
endef

ldv-sandbox.f-dep = ldv-sandbox..dep-$1
ldv-sandbox.f-prereq = $(call ldv-dep.f-target,ldv-sandbox..dep-$1)
ldv-sandbox.f-env = PATH=$(ldv-tools-pwd)/$(call ldv-sandbox..f-root,$1)$(ldv-tools-chr-sp)

# ================================================================================
# Implementation

ldv-sandbox..root = $(call ldv-vars.f-get,ldv-base-path)/sandbox
ldv-sandbox..f-root = $(ldv-sandbox..root)/bin-$1-$(call ldv-dep.f-sha,ldv-sandbox..dep-$1)

$(call ldv-bin.f-required,touch)
$(call ldv-bin.f-required,ln)

ldv-sandbox..f-rules = $(foreach s,$(ldv-sandbox..all),$(eval $(call ldv-sandbox..f-one-rule,$(s))))

define ldv-sandbox..f-one-rule
$(call ldv-dep.f-target,ldv-sandbox..dep-$1): $(call ldv-dep.f-prereq,ldv-sandbox..dep-$1)
	$(call ldv-bin.f-exec,mkdir) -p $(call ldv-sandbox..f-root,$1)
	$(foreach b,$(ldv-sandbox..bins-$1),$(call ldv-sandbox..f-create-link,$1,$b)$(ldv-tools-next-cmd))
	$(call ldv-dep.f-touch,$$@)
endef

ldv-sandbox..f-create-link = $(call ldv-bin.f-exec,ln) -s $(call ldv-bin.f-exec,$2) $(call ldv-sandbox..f-root,$1)/$2

$(call ldv-mod-provide,ldv-sandbox,ldv-sandbox..f-rules)

endif


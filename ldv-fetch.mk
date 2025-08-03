# SPDX-License-Identifier: MIT
#
# Routintes related to download from
# external sources
#

ifndef ldv-fetch..included
ldv-fetch..included := 1

include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-curl.mk
include $(ldv-root)/ldv-debug.mk

$(call ldv-vars.f-must-not-empty,ldv-base-path)
ldv-fetch.downloads = $(ldv-base-path)/downloads

# ================================================================================
# Interface
#
# $1 descriptor of the fetch
define ldv-fetch.f_define
  $(eval
    $(call ldv-vars.f-store,ldv-fetch,$(ldv-fetch..all-vars))
    $(call ldv-vars.f-clear,$(ldv-fetch..all-vars))
    $($1))
  $(eval
    # Check that .name is defined
    $(call ldv-vars.f-must-not-empty,.name,Fetch name must be defined)
    $(call ldv-debug.f-info,ldv-fetch: defining variables for $(.name))
    # Copy all variables to variables
    $(foreach v,$(ldv-fetch..all-vars),$(eval
         ldv-fetch..[$(.name)].vars$v:= $($(v))
      ))
    # Append package to list of all packages
    ldv-fetch..all += $(.name)
    # Define dependencies
    $(call ldv-dep.f-define,ldv-fetch..[$(.name)].dep,$(foreach v,$(ldv-fetch..all-vars),$($(v))),)
    # unset all variables
    $(call ldv-vars.f-restore,ldv-fetch,$(ldv-fetch..all-vars)))
endef

ldv-fetch.f-name = $(call ldv-fetch..f-destination,$1)
ldv-fetch.f-dep = ldv-fetch..[$1].dep

# ================================================================================
# Implementation
#

$(call ldv-bin.f-required,touch)
$(call ldv-bin.f-required,mkdir)

ldv-fetch..all-vars := .name .method .source .target-ext
ldv-fetch..downloads-dir-dep = $(ldv-fetch.downloads)/.dep

define ldv-fetch..f-rules
$(ldv-fetch..downloads-dir-dep):
	$(call ldv-bin.f-exec,mkdir) -p $(ldv-fetch.downloads)
	$(call ldv-bin.f-exec,touch) $$@

$(foreach s,$(ldv-fetch..all),$(eval $(call ldv-fetch..f-one-rule,$(s))))
endef

ldv-fetch..f-destination = $(ldv-fetch.downloads)/$1-$(call ldv-dep.f-sha,ldv-fetch..[$1].dep).$(ldv-fetch..[$1].vars.target-ext)
ldv-fetch..f-download-curl = $(call ldv-curl.f-download,$1,$2)

define ldv-fetch..f-one-rule
$(call ldv-debug.f-info,Define fetch package $1)

$(call ldv-dep.f-target,ldv-fetch..[$1].dep): $(ldv-fetch..downloads-dir-dep) $(call ldv-dep.f-prereq,ldv-fetch..[$1].dep)
	$(call ldv-fetch..f-download-$(ldv-fetch..[$1].vars.method),$(ldv-fetch..[$1].vars.source),$(call ldv-fetch..f-destination,$1))
	$(call ldv-dep.f-touch,$$@)

endef

$(call ldv-mod-provide,ldv-fetch,ldv-fetch..f-rules)

endif

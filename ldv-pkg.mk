# SPDX-License-Identifier: MIT
#
# Package definition
#

ifndef ldv-pkg..included

ldv-pkg..included := 1

include $(ldv-root)/ldv-dep.mk
include $(ldv-root)/ldv-mod.mk
include $(ldv-root)/ldv-vars.mk
include $(ldv-root)/ldv-fetch.mk

# ================================================================================
# Interface

# $1 descriptor of the package
define ldv-pkg-f-define
  $(eval
    $(call ldv-vars.f-store,ldv-pkg,$(ldv-pkg..all-vars))
    $(call ldv-vars.f-clear,$(ldv-pkg..all-vars))
    $($1))
  $(eval
    # Check that .name is defined
    $(call ldv-vars.f-must-not-empty,.name)
    # Copy all variables to variables to ldv-pkg..pkg-
    $(foreach v,$(ldv-pkg..all-vars),$(eval
         ldv-pkg..pkg$v-$(.name) := $($(v))
      ))
    # Append package to list of all packages
    ldv-pkg..all-pkgs += $(.name)
    # Check that all .deps are defined as packages:
    $(foreach p,$(.deps),$(if $(filter $p,$(ldv-pkg..all-pkgs)),,$(error Dependency package $p is not defined))))
  $(eval
    # Define fetch method
    define ldv-pkg..fetch-$(.name)
       .name := $(.name)
       .method := $(ldv-pkg..fetch-methods-$(.repo-type))
       .source := $(call ldv-pkg..f-fetch-source-$(.repo-type),$(.repo-name),$(.version))
       .target-ext := $(ldv-pkg..fetch-target-ext-$(.repo-type))
    endef
  )
  $(eval
    $(call ldv-fetch.f_define,ldv-pkg..fetch-$(.name))
    # Define dependencies
    $(call ldv-dep.f-define,ldv-pkg..dep-$(.name),$(foreach v,$(ldv-pkg..all-vars),$($(v))),$(call ldv-fetch.f-dep,$(.name)) $(foreach p,$(.deps),ldv-pkg..dep-$p))
    # restore all variables
    $(call ldv-vars.f-restore,ldv-pkg,$(ldv-pkg..all-vars)))
endef # ldv-pkg-f-define

# ================================================================================
# Implementation

# All defined packages
ldv-pkg..all-pkgs :=

ldv-pkg..all-vars := .name .version .repo-type .repo-name .deps

ldv-pkg..fetch-methods-gnu := curl
ldv-pkg..fetch-target-ext-gnu = tar.gz
ldv-pkg..f-fetch-source-gnu = https://alpha.gnu.org/gnu/$1/$1-$2.$(ldv-pkg..fetch-target-ext-gnu)

ldv-pkg..f-rules = $(foreach s,$(ldv-pkg..all-pkgs),$(eval $(call ldv-pkg..f-one-rule,$(s))))

define ldv-pkg..f-one-rule
$(info Define package $1)

$(call ldv-dep.f-target,ldv-pkg..dep-$1): $(call ldv-dep.f-prereq,ldv-pkg..dep-$1)
	$(call ldv-dep.f-touch,$$@)

endef

$(call ldv-mod-provide,ldv-pkg,ldv-pkg..f-rules)

endif

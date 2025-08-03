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
include $(ldv-root)/ldv-debug.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-sandbox.mk
include $(ldv-root)/ldv-tools.mk
include $(ldv-root)/pkg/ldv-subst.mk

$(call ldv-bin.f-required,touch)
$(call ldv-bin.f-required,mkdir)
$(call ldv-bin.f-required,make)
$(call ldv-bin.f-required,rm)

$(call ldv-vars.f-must-not-empty,ldv-base-path)
ldv-pkg.base-path = $(ldv-base-path)/pkg

# ================================================================================
# Interface

# $1 descriptor of the package
define ldv-pkg-f-define
  $(eval
    $(call ldv-vars.f-store,ldv-pkg,$(ldv-pkg..all-vars))
    $(call ldv-vars.f-clear,$(ldv-pkg..all-vars))
    $($1)
    .makefile-vars ?=
    .build-sandbox ?=
    .deps ?=
    .tools ?=
  )
  $(eval
    # Check that .name is defined
    $(call ldv-vars.f-must-not-empty,.name)
    # For each tool in .tools classify it between sandbox or dependency
    $(foreach t,$(.tools),$(call ldv-bin.f-available,$t,.build-sandbox += $t,$(call ldv-pkg..f-add-deps,$t,.deps,$1)))
    # Copy all variables to variables to ldv-pkg..pkg-
    $(foreach v,$(ldv-pkg..all-vars),$(eval
         ldv-pkg..vars$v@$(.name) := $($(v))
      ))
    # Append package to list of all packages
    ldv-pkg..all-pkgs += $(.name)
    # Check that all .deps are defined as packages:
    $(foreach p,$(.deps),$(if $(filter $p,$(ldv-pkg..all-pkgs)),,$(error Dependency package $p is not defined))))
  $(eval
    # Define fetch method
    define ldv-pkg..download@$(.name)
       .name := ldv-pkg..download@$(.name)
       .method := $(call ldv-vars.f-get,ldv-pkg..fetch-methods-$(.repo-type),Unknown repo type $(.repo-type))
       .source := $(call ldv-pkg..f-fetch-source-$(.repo-type),$(.repo-name),$(.version))
       .target-ext := $(ldv-pkg..fetch-target-ext-$(.repo-type))
    endef
  )
  $(eval
    # Define sandbox for build
    $(if $(.build-sandbox),$(call ldv-sandbox.f-define,ldv-pkg.build@$(.name),$(.build-sandbox)))
    # Paths from sandbox:
    ldv-pkg..path-sandbox@$(.name) = $(if $(.build-sandbox),$(call ldv-sandbox.f-path,ldv-pkg.build@$(.name)))
    # Paths from dependencies:
    ldv-pkg..path-deps@$(.name) = $(foreach d,$(.deps),$(call ldv-pkg.f-prefix,$d)/$(call ldv-vars.f-get,ldv-pkg..vars.env-path@$d))) 
  $(eval
    $(call ldv-debug.f-info,ldv-pkg: $(.name): dependencies path: $(ldv-pkg..path-deps@$(.name)))
    $(call ldv-debug.f-info,ldv-pkg: $(.name): sandbox path: $(ldv-pkg..path-sandbox@$(.name)))
    ldv-pkg..build-env@$(.name) = PATH=$(call ldv-tooks.f-join,:,$(ldv-pkg..path-sandbox@$(.name)) $(ldv-pkg..path-deps@$(.name))) 
    ldv-pkg..build-env-dep@$(.name) = $(if $(.build-sandbox),$(call ldv-sandbox.f-dep,ldv-pkg.build@$(.name))))
  $(eval
    $(call ldv-debug.f-info,ldv-pkg: $(.name): build environment: $(ldv-pkg..build-env@$(.name)))
    $(call ldv-debug.f-info,ldv-pkg: var-deps: $(foreach v,$(ldv-pkg..all-vars),$(v)=$($(v))))
    $(call ldv-fetch.f_define,ldv-pkg..download@$(.name))
    # Define dependencies
    $(call ldv-dep.f-define,ldv-pkg..dep-$(.name),
         $(foreach v,$(ldv-pkg..all-vars),$(v)=$($(v))), \
         $(call ldv-fetch.f-dep,ldv-pkg..download@$(.name)) \
            $(ldv-pkg..build-env-dep@$(.name)) \
            $(foreach p,$(.deps),ldv-pkg..dep-$p) \
            $(call ldv-sandbox.f-dep,ldv-pkg..extract-tar-gz))
    ldv-dep..ldv-build-vars@$(.name) := ldv-install-prefix=$(call ldv-pkg.f-prefix,$(.name)) $(if $(.makefile-vars),$(.makefile-vars))
    # restore all variables
    $(call ldv-vars.f-restore,ldv-pkg,$(ldv-pkg..all-vars)))
endef # ldv-pkg-f-define

ldv-pkg.f-prefix = $(ldv-tools-pwd)/$(call ldv-pkg..f-dir,$1)/install$(call ldv-vars.f-must-not-empty,ldv-pkg..vars.name@$1,Package $1 is not defined)
ldv-pkg.f-dep = $(call ldv-dep.f-target,ldv-pkg..dep-$1)

# ================================================================================
# Implementation

$(call ldv-sandbox.f-define,ldv-pkg..extract-tar-gz,tar gzip)

# All defined packages
ldv-pkg..all-pkgs :=

ldv-pkg..all-vars := .name .version .repo-type .repo-name .deps .makefile .makefile-vars .build-sandbox .env-path .tools

ldv-pkg..f-dir = $(ldv-pkg.base-path)/$1-$(call ldv-dep.f-sha,ldv-pkg..dep-$1)

ldv-pkg..fetch-methods-gnu := curl
ldv-pkg..fetch-target-ext-gnu = tar.gz
ldv-pkg..f-fetch-source-gnu = https://ftp.gnu.org/gnu/$1/$1-$2.$(ldv-pkg..fetch-target-ext-gnu)
ldv-pkg..f-extract-gnu = $(call ldv-sandbox.f-env,ldv-pkg..extract-tar-gz)tar zxf $(call ldv-fetch.f-name,ldv-pkg..download@$1) -C $(call ldv-pkg..f-dir,$1)/src --strip-components=1  

ldv-pkg..fetch-methods-curl-tar-gz := curl
ldv-pkg..fetch-target-ext-curl-tar-gz = tar.gz
ldv-pkg..f-fetch-source-curl-tar-gz = $1
ldv-pkg..f-extract-curl-tar-gz = $(call ldv-sandbox.f-env,ldv-pkg..extract-tar-gz)tar zxf $(call ldv-fetch.f-name,ldv-pkg..download@$1) -C $(call ldv-pkg..f-dir,$1)/src --strip-components=1  

ldv-pkg..fetch-methods-github := curl
ldv-pkg..fetch-target-ext-github = tar.gz
ldv-pkg..f-fetch-source-github = https://github.com/$1/archive/refs/tags/$2.$(ldv-pkg..fetch-target-ext-github)
ldv-pkg..f-extract-github = $(call ldv-sandbox.f-env,ldv-pkg..extract-tar-gz)tar zxf $(call ldv-fetch.f-name,ldv-pkg..download@$1) -C $(call ldv-pkg..f-dir,$1)/src --strip-components=1  

ldv-pkg..f-rules = $(foreach s,$(ldv-pkg..all-pkgs),$(eval $(call ldv-pkg..f-one-rule,$(s))))

define ldv-pkg..f-one-rule
$(call ldv-debug.f-info,ldv-pkg: define package $1 rules)

$(call ldv-dep.f-target,ldv-pkg..dep-$1): $(call ldv-dep.f-prereq,ldv-pkg..dep-$1)
	$(call ldv-bin.f-exec,rm) -rf $(call ldv-pkg..f-dir,$1)
	$(call ldv-bin.f-exec,mkdir) -p $(call ldv-pkg..f-dir,$1)/src
	$(call ldv-bin.f-exec,mkdir) -p $(call ldv-pkg.f-prefix,$1)
	$(call ldv-pkg..f-extract-$(ldv-pkg..vars.repo-type@$1),$1)
	$(ldv-pkg..build-env@$1)$(call ldv-bin.f-exec,make) -f $(ldv-root)/$(ldv-pkg..vars.makefile@$1) -C $(call ldv-pkg..f-dir,$1)/src $(ldv-dep..ldv-build-vars@$1)
	$(call ldv-dep.f-touch,$$@)

endef

define ldv-pkg..f-add-deps
  include $$(call ldv-subst.f-path,$1)
  $2 += $$(call ldv-subst.f-pkg,$1)
  $$(info 🚀 Package for $1 will be built required by $3)
endef

$(call ldv-mod-provide,ldv-pkg,ldv-pkg..f-rules)

endif

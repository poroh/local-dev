# SPDX-License-Identifier: MIT
#
# Routintes related to executables
#

ifndef ldv-bin..included
ldv-bin..included := 1

include $(ldv-root)/ldv-vars.mk
include $(ldv-root)/ldv-debug.mk

$(if $(shell which $(SHELL)),,$(error which must be installed))

# ================================================================================
# Interface

# ldv-bin.f-required: Check that $1 program installed and define variable with full path
# $1 - program name
# Example:
# $(call ldv-bin.f-required,sha256sum)
#
define ldv-bin.f-required
  $(eval $(call ldv-bin..f-required-1,$1))
  $(eval $(call ldv-bin..f-required-2,$1))
endef

ldv-bin.f-exec = $(call ldv-vars.f-get,ldv-bin..path-$1,Binary for $1 is not defined)
ldv-bin.f-seal = $(eval $(call ldv-bin..seal))

# ================================================================================
# Implementation
define ldv-bin..f-required-1
  ldv-bin..path-$1 := $(shell which $1)
endef

define ldv-bin..f-required-2
  ldv-bin..all-bin += $(call ldv-vars.f-get,ldv-bin..path-$1,Cannot find $1)
endef

$(call ldv-bin.f-required,bash)

define ldv-bin..seal
  $(call ldv-debug.f-info,ldv-bin: executable are sealed. No more execs from PATH)
  export PATH :=
  export SHELL := $(call ldv-bin.f-exec,bash)
endef

endif # ifndef ldv-bin..included

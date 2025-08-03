# SPDX-License-Identifier: MIT
#
# Detection of OS-dependentcy
#

ifndef ldv-uname..included
ldv-uname..included := 1

include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-vars.mk

$(call ldv-bin.f-required,uname)

# ================================================================================
# Interface

ldv-uname.current = $(call ldv-vars.f-get,ldv-uname..map.$(ldv-uname..uname),Cannot map uname output $(ldv-uname..uname))

# ================================================================================
# Implementation

ldv-uname..uname := $(shell $(call ldv-bin.f-exec,uname))
ldv-uname..map.Darwin := darwin
ldv-uname..map.Linux := linux

endif

# SPDX-License-Identifier: MIT
#
# Routines related to Makefile variables
#

ifndef ldv-vars--included
ldv-vars--included := 1

ldv-vars-debug ?=
ldv-vars-f-must-not-empty = $(if $($1),$(call ldv-vars-debug-print,$1),$(error $(if $2,$2,$1 must be defined)))
ldv-vars-f-debug-print = $(if $(ldv-vars-debug),$(info $1 = $($1))) 

endif # ifndef ldv-vars--included

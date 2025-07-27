# SPDX-License-Identifier: MIT
#
# Debuging of LDV
#

ifndef ldv-debug..included
ldv-debug..included := 1

ldv-debug ?=
ldv-debug.f-info = $(if $(ldv-debug),$(info $1))

ldv-debug.f-todo = $(error Hit todo: $1)

endif

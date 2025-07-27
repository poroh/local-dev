# SPDX-License-Identifier: MIT
#
# Latest to be included in Makefile
#

# ================================================================================
# Interface
#
# Next command in recipe
ldv-tools-pwd := $(shell pwd)
ldv-tools-next-cmd = $(ldv-tools--newline)$(ldv-tools--indent)
ldv-tools-chr-sp = $(ldv-tools--empty) $(ldv-tools--empty)

# ================================================================================
# Implementation
#
ldv-tools--empty=
define ldv-tools--newline
$(ldv-tools--empty)
$(ldv-tools--empty)
endef
ldv-tools--indent=$(ldv-tools--empty)	$(ldv-tools--empty)

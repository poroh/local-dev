# SPDX-License-Identifier: MIT
#
# Latest to be included in Makefile
#

ifndef ldv-tools--included
ldv-tools--included := 1

ldv-tools-make-major = $(firstword $(subst ., ,$(MAKE_VERSION))))

# ================================================================================
# Interface
#
# pwd
ldv-tools-pwd := $(shell pwd)
# Next command in recipe
ldv-tools-next-cmd = $(ldv-tools--newline)$(ldv-tools--indent)
ldv-tools-chr-sp = $(ldv-tools--empty) $(ldv-tools--empty)

# Make version
$(if $(intcmp 3,4,lt,,),,$(error Your version of make must be at least 4.4. Your version $(MAKE_VERSION)))
ldv-tools-make-major := $(firstword $(subst ., ,$(MAKE_VERSION)))
ldv-tools-make-minor := $(word 2,$(subst ., ,$(MAKE_VERSION)))
ldv-tools.f-require-make-version = $(if $(intcmp $(ldv-tools-make-major),$1,no-go,$(intcmp $(ldv-tools-make-minor),$2,no-go,,),),$(error make is too old $(MAKE_VERSION) < $1.$2))

# ================================================================================
# Implementation
#

ldv-tools--empty=
define ldv-tools--newline
$(ldv-tools--empty)
$(ldv-tools--empty)
endef
ldv-tools--indent=$(ldv-tools--empty)	$(ldv-tools--empty)

endif

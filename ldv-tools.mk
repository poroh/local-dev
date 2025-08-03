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

# intcmp (in future make it will be a function):
ldv-tool.f-intcmp = $(shell \
  if [ $(1) -lt $(2) ]; then echo '$3'; \
  elif [ $(1) -eq $(2) ]; then echo '$4'; \
  else echo $5; fi \
)

# Make version
ldv-tools-make-major := $(firstword $(subst ., ,$(MAKE_VERSION)))
ldv-tools-make-minor := $(word 2,$(subst ., ,$(MAKE_VERSION)))
ldv-tools.f-require-make-version = $(if $(call ldv-tools.f-intcmp,$(ldv-tools-make-major),$1,no-go,$(call ldv-tools.f-intcmp,$(ldv-tools-make-minor),$2,no-go,,),),$(error make is too old $(MAKE_VERSION) < $1.$2))

# Join strings
# $1 - sep
# $2 - list of strings
ldv-tools.f-join = $(subst $(ldv-tools-chr-sp),$1,$(strip $2))

ldv-tools.f-get-j = $(filter -j%,$1)

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

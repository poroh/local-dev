# SPDX-License-Identifier: MIT
#
# Test of pkg postgres
#

pwd := $(shell pwd)
ldv-root := $(pwd)/..
include $(ldv-root)/ldv-bin.mk

ldv-base-path := _build/test-pkg-postgres

include $(ldv-root)/pkg/github/postgres/import.mk

$(call ldv-bin.f-required,rm)

$(call ldv-bin.f-seal)

all: $(call postgres.f-dep)

clean:
	$(call ldv-bin.f-exec,rm) -rf $(ldv-base-path)

include $(ldv-root)/ldv-footer.mk


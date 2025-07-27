# SPDX-License-Identifier: MIT
#
# Test of ldv-sandbox
#

pwd := $(shell pwd)
ldv-root := $(pwd)/..

ldv-base-path := _build/test-ldv-sandbox

include $(ldv-root)/ldv-sandbox.mk

$(call ldv-sandbox.f-define,my-sandbox,tar)

$(call ldv-bin.f-seal)

all: $(call ldv-sandbox.f-prereq,my-sandbox)
	$(call ldv-sandbox.f-env,my-sandbox)tar --version

clean:
	$(call ldv-bin.f-exec,rm) -rf $(ldv-base-path) 

include $(ldv-root)/ldv-footer.mk

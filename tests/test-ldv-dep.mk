# SPDX-License-Identifier: MIT
#
# Test of ldv-dep module
#

pwd := $(shell pwd)
ldv-root := $(pwd)/..

ldv-dep-base-path := _build/test-ldv-dep
include $(ldv-root)/ldv-dep.mk
include $(ldv-root)/ldv-bin.mk

$(call ldv-bin-f-required,rm)

$(call ldv-dep-define,i1,i1-v1)
$(call ldv-dep-define,i2,i2-v3)

$(call ldv-dep-define,test-target,,i1 i2)

$(call ldv-bin-f-seal)

all: $(call ldv-dep-f-target,test-target)

clean:
	$(call ldv-bin-f-exec,rm) -rf $(ldv-dep-base-path) 

$(call ldv-dep-f-target,i1): $(call ldv-dep-f-prereq,i1)
	$(ldv-dep-touch)

$(call ldv-dep-f-target,i2): $(call ldv-dep-f-prereq,i2)
	$(ldv-dep-touch)

$(call ldv-dep-f-target,test-target): $(call ldv-dep-f-prereq,test-target)
	$(ldv-dep-touch)

include $(ldv-root)/ldv-footer.mk

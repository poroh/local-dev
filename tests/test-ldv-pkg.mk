# SPDX-License-Identifier: MIT
#
# Test of ldv-pkg module
#

pwd := $(shell pwd)
ldv-root := $(pwd)/..
include $(ldv-root)/ldv-bin.mk

ldv-base-path := _build/test-ldv-pkg

include $(ldv-root)/pkg/gnu/hello/import.mk

gnu-hello-version := 2.3.90
include $(ldv-root)/pkg/gnu/hello/import.mk

gnu-hello-version := 2.4.90
include $(ldv-root)/pkg/gnu/hello/import.mk

$(call ldv-bin.f-required,rm)

$(call ldv-bin.f-seal)

all: $(ldv-dep.all)
	$(call gnu-hello.f-exec,2.3.90) --version
	$(call gnu-hello.f-exec) --version
	PATH=$(call gnu-hello.f-path,2.4.90) hello --version

clean:
	$(call ldv-bin.f-exec,rm) -rf $(ldv-base-path)

include $(ldv-root)/ldv-footer.mk


# SPDX-License-Identifier: MIT
#
# Test of ldv-pkg module
#

pwd := $(shell pwd)
ldv-root := $(pwd)/..
include $(ldv-root)/ldv-bin.mk

ldv-base-path := _build/test-ldv-pkg

include $(ldv-root)/pkg/gnu/hello/import.mk

gnu-hello-version := 2.8
include $(ldv-root)/pkg/gnu/hello/import.mk

gnu-hello-version := 2.9
include $(ldv-root)/pkg/gnu/hello/import.mk

include $(ldv-root)/pkg/gnu/sed/import.mk
include $(ldv-root)/pkg/gnu/tar/import.mk

$(call ldv-bin.f-required,rm)

$(call ldv-bin.f-seal)

all: $(ldv-dep.all)
	$(call gnu-hello.f-exec,2.8) --version
	$(call gnu-hello.f-exec) --version
	PATH=$(call gnu-hello.f-path,2.9) hello --version
	PATH=$(call gnu-sed.f-path) sed --version
	PATH=$(call gnu-tar.f-path) tar --version

clean:
	$(call ldv-bin.f-exec,rm) -rf $(ldv-base-path)

include $(ldv-root)/ldv-footer.mk


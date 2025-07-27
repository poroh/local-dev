# SPDX-License-Identifier: MIT
#
# Test of ldv-pkg module
#

pwd := $(shell pwd)
ldv-root := $(pwd)/..

ldv-base-path := _build/test-ldv-pkg
include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

$(call ldv-bin.f-required,rm)

define hello-world-descr
  .name      := hello-world
  .version   := 2.6.90
  .repo-type := gnu
  .repo-name := hello
  .deps      :=
endef

$(call ldv-pkg-f-define,hello-world-descr)

$(call ldv-bin.f-seal)

all: $(ldv-dep.all)

clean:
	$(call ldv-bin.f-exec,rm) -rf $(ldv-base-path)

include $(ldv-root)/ldv-footer.mk


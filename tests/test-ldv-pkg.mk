# SPDX-License-Identifier: MIT
#
# Test of ldv-pkg module
#

pwd := $(shell pwd)
ldv-root := $(pwd)/..

$(info $(PATH))

ldv-base-path := _build/test-ldv-pkg
include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk

$(eval $(call ldv-bin.f-required,rm))

define hello-world-descr
  .name      := hello-world
  .version   := 2.6.90
  .repo-type := gnu
  .repo-name := hello
  .deps      :=
  .makefile  := test-ldv-pkg.hello-world.mk
  .build-sandbox := sed expr rm ls mv cp mkdir touch cat sort chmod tr awk uniq grep uname sleep make cc ld
endef

$(eval $(call ldv-pkg-f-define,hello-world-descr))

$(call ldv-bin.f-seal)

all: $(ldv-dep.all)

clean:
	$(call ldv-bin.f-exec,rm) -rf $(ldv-base-path)

include $(ldv-root)/ldv-footer.mk


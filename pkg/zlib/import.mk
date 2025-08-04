# SPDX-License-Identifier: MIT
#
# zlib package
#

zlib-default-version := 1.3.1
zlib-version ?= $(zlib-default-version)

ifndef zlib..included-$(zlib-version)
zlib..included-$(zlib-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

zlib.configure-flags ?= --static

define zlib-descr
  .name      := zlib-$(zlib-version)
  .version   := $(zlib-version)
  .repo-type := curl-tar-gz
  .repo-name := https://www.zlib.net/zlib-$(zlib-version).tar.gz
  .deps      := $(call gnu-ncurses.f-pkg)
  .makefile  := build/configure-build.mk
  .makefile-vars := configure-flags='$(zlib.configure-flags)'
  .build-sandbox := $(ldv-c-toolchain.tools) \
                    bash expr date dirname tee sed rm \
                    make sh cat cp mv mkdir ln chmod
  .env-path  := bin
endef

$(call ldv-pkg-f-define,zlib-descr)

zlib.f-pkg = zlib-$(if $1,$1,$(zlib-version))
zlib.f-prefix = $(call ldv-pkg.f-prefix,zlib-$(if $1,$1,$(zlib-version)))
zlib.f-cppflags = -I$(call zlib.f-prefix,$1)/include
zlib.f-ldflags = -L$(call zlib.f-prefix,$1)/lib

endif

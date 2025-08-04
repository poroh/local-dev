# SPDX-Licexnse-Identifier: MIT
#
# GNU ncurses package
#

openssl-default-version := openssl-3.5.1
openssl-version ?= $(openssl-default-version)

ifndef openssl..included-$(openssl-version)
openssl..included-$(openssl-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

define openssl-descr
  .name      := openssl-$(openssl-version)
  .version   := $(openssl-version)
  .repo-type := github
  .repo-name := openssl/openssl
  .deps      := 
  .makefile  := pkg/github/openssl/build.mk
  .makefile-vars := configure-flags='$(openssl.configure-flags)'
  .tools := $(ldv-c-toolchain.tools) \
            perl bash sh touch mv make rm chmod ln cut basename cp
  .env-path  := bin
endef

$(call ldv-pkg-f-define,openssl-descr)

openssl.f-pkg = openssl-$(if $1,$1,$(openssl-version))
openssl.f-ldflags = -L$(call ldv-pkg.f-prefix,openssl-$(if $1,$1,$(openssl-version)))/lib
openssl.f-cflags = -I$(call ldv-pkg.f-prefix,openssl-$(if $1,$1,$(openssl-version)))/include

endif

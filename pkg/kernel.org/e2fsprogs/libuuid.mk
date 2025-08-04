# SPDX-License-Identifier: MIT
#
# libuuid from e2fsprogs package
#

e2fsprogs-libuuid-default-version := 1.47.3
e2fsprogs-libuuid-version ?= $(e2fsprogs-libuuid-default-version)

ifndef e2fsprogs-libuuid..included-$(e2fsprogs-libuuid-version)
e2fsprogs-libuuid..included-$(e2fsprogs-libuuid-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

e2fsprogs-libuuid.configure-flags = \
   CFLAGS="-O2" \
   --enable-libuuid \
   --disable-backtrace \
   --disable-debugfs \
   --disable-imager \
   --disable-resizer \
   --disable-defrag \
   --disable-tls \
   --disable-uuidd \
   --disable-mmp \
   --disable-tdb \
   --disable-bmap-stats \
   --disable-nls \
   --disable-rpath \
   --disable-largefile \
   --disable-fuse2fs

define e2fsprogs-libuuid-descr
  .name      := e2fsprogs-libuuid-$(e2fsprogs-libuuid-version)
  .version   := $(e2fsprogs-libuuid-version)
  .repo-type := curl-tar-gz
  .repo-name := https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$(e2fsprogs-libuuid-version)/e2fsprogs-$(e2fsprogs-libuuid-version).tar.gz
  .deps      := 
  .makefile  := pkg/kernel.org/e2fsprogs/build-libuuid.mk
  .makefile-vars := configure-flags='$(e2fsprogs-libuuid.configure-flags)'
  .build-sandbox := $(ldv-c-toolchain.tools) \
                    sh sed expr rm ls cat sort awk \
                    mv grep uname chmod cp uniq dirname \
                    mkdir tr make touch ln true
  .env-path  := bin
endef

$(call ldv-pkg-f-define,e2fsprogs-libuuid-descr)

e2fsprogs-libuuid.f-pkg = e2fsprogs-libuuid-$(if $1,$1,$(e2fsprogs-libuuid-version))
e2fsprogs-libuuid.f-ldflags = -L$(call ldv-pkg.f-prefix,e2fsprogs-libuuid-$(if $1,$1,$(e2fsprogs-libuuid-version)))/lib
e2fsprogs-libuuid.f-cppflags = -I$(call ldv-pkg.f-prefix,e2fsprogs-libuuid-$(if $1,$1,$(e2fsprogs-libuuid-version)))/include

endif

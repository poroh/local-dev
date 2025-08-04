# SPDX-License-Identifier: MIT
#
# Build libuuid from e2fsprogs package
#

all:
	./configure --prefix=$(ldv-install-prefix) $(configure-flags)
	MAKEFLAGS= MFLAGS= make -C lib/uuid
	make -C lib/uuid install

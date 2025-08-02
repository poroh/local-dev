# SPDX-License-Identifier: MIT
#
# Build of readline
# readlines wants cleared MFLAGS so it has custom build
#

export SHELL=bash

build:
	./configure --prefix $(ldv-install-prefix) $(configure-flags)
	MFLAGS= MAKEFLAGS= make
	make install

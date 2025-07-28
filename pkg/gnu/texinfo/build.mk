# SPDX-License-Identifier: MIT
#
# Build of hello
#

export SHELL=bash

build:
	chmod a+x ./build-aux/install-sh
	./configure --prefix $(ldv-install-prefix) --disable-dependency-tracking CFLAGS=-O2
	make
	make install

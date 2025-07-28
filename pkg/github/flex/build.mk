# SPDX-License-Identifier: MIT
#
# Build of bison
#

export SHELL=bash

build:
	AUTOMAKE=$(automake-bin) AUTOCONF=$(autoconf-bin) LIBTOOLIZE=$(shell which libtoolize) LIBTOO=$(shell which libtool) bash -x ./autogen.sh
	./configure CFLAGS='-O2' --prefix $(ldv-install-prefix) --disable-bootstrap
	make
	make install

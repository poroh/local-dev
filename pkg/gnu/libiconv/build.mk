# SPDX-License-Identifier: MIT
#
# Build of hello
#

export SHELL=bash

build:
	chmod a+x ./build-aux/install-sh
	./configure --prefix $(ldv-install-prefix) --disable-dependency-tracking --without-libintl-prefix CFLAGS=-O2 --with-libiconv-prefix=$(ldv-prefix-gnu-libiconv)
	make
	make install

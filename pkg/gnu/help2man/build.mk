# SPDX-License-Identifier: MIT
#
# Build of hello
#

export SHELL=bash

build:
	./configure --prefix $(ldv-install-prefix) CFLAGS=-O2
	make
	make install

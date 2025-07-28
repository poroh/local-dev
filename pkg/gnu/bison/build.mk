# SPDX-License-Identifier: MIT
#
# Build of bison
#

export SHELL=bash

build:
	./configure CFLAGS='-O2' --prefix $(ldv-install-prefix)
	make
	make install

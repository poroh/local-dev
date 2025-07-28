# SPDX-License-Identifier: MIT
#
# Build of M4
#

export SHELL=bash

build:
	./configure CFLAGS="-O3" --prefix $(ldv-install-prefix)
	make
	make install

# SPDX-License-Identifier: MIT
#
# Build of bison
#

export SHELL=bash

build:
	./configure --prefix=$(ldv-install-prefix) --openssldir=$(ldv-install-prefix) 
	make
	make install

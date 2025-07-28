# SPDX-License-Identifier: MIT
#
# Build of bison
#

export SHELL=bash

build:
	./Configure -Dprefix=$(ldv-install-prefix) -der -Uusedl
	make
	make install

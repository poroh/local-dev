# SPDX-License-Identifier: MIT
#
# Build of hello
#

export SHELL=bash

build:
	chmod a+x ./build-aux/install-sh
	./configure --prefix $(ldv-install-prefix) $(configure-flags)
	make
	make install

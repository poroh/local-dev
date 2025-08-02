# SPDX-License-Identifier: MIT
#
# Default build for packages with
# ./configure
# make
# make install
#

export SHELL=bash

build:
	./configure --prefix $(ldv-install-prefix) $(configure-flags)
	make
	make install

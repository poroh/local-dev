# SPDX-License-Identifier: MIT
#
# Build of postgres
#

export SHELL=bash

build:
	./configure --prefix $(ldv-install-prefix) --without-icu
	make
	make install

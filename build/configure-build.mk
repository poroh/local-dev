# SPDX-License-Identifier: MIT
#
# Default build for packages with
# ./configure
# make
# make install
#

export SHELL=bash

make-env ?=

build:
	./configure --prefix $(ldv-install-prefix) $(configure-flags)
	$(make-env)make
	make install

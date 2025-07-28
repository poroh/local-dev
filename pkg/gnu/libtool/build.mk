# SPDX-License-Identifier: MIT
#
# Build of bison
#

export SHELL=bash

build:
	./configure CFLAGS='-O2 -Wno-compound-token-split-by-macro -Wno-constant-logical-operand' --prefix $(ldv-install-prefix) --disable-dependency-tracking --disable-silent-rules --disable-ltdl-install
	make
	make install

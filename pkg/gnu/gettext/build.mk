# SPDX-License-Identifier: MIT
#
# Build of bison
#

export SHELL=bash

build:
	./configure CFLAGS='-O2 -I$(libiconv-prefix)/include' LDFLAGS='-L$(libiconv-prefix)/lib -liconv' --prefix $(ldv-install-prefix) --disable-dependency-tracking --disable-silent-rules
	make
	make install

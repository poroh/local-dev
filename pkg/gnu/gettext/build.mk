# SPDX-License-Identifier: MIT
#
# Build of bison
#

export SHELL=bash

configure-args = --disable-dependency-tracking  \
                 --disable-silent-rules \
                 --without-emacs \
                 --disable-modula2 \
                 --enable-fast-install \
                 --disable-d \
                 --disable-java

build:
	./configure CFLAGS='-O2 -I$(libiconv-prefix)/include' LDFLAGS='-L$(libiconv-prefix)/lib -liconv' --prefix $(ldv-install-prefix) $(configure-args)
	make
	make install

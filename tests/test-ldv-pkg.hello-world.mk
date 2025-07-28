#
#
#

export SHELL=bash

build:
	chmod a+x ./build-aux/install-sh
	./configure --prefix $(ldv-install-prefix) --disable-dependency-tracking --without-libintl-prefix CFLAGS=-O0
	make
	make install

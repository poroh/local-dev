#
#
#

build:
	./configure --prefix $(ldv-install-prefix) --disable-dependency-tracking --without-libintl-prefix
	make
	make install

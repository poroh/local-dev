# SPDX-License-Identifier: MIT
#
# Run tests of ldv
#

tests:
	make clean -f ./test-ldv-dep.mk
	make -f ./test-ldv-dep.mk
	make clean -f ./test-ldv-sandbox.mk
	make -f ./test-ldv-sandbox.mk
	make clean -f ./test-ldv-pkg.mk
	make -r -R -f ./test-ldv-pkg.mk


#	make clean -f ./test-ldv-pkg-xz.mk
#	make -f ./test-ldv-pkg-xz.mk

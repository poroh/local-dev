# SPDX-License-Identifier: MIT
#
# Run tests of ldv
#

tests:
	make -f ./test-ldv-dep.mk
	make -f ./test-ldv-sandbox.mk
	make -r -R -f ./test-ldv-pkg.mk
	make -r -R -f ./test-pkg-postgres.mk

clean:
	make clean -f ./test-ldv-dep.mk
	make clean -f ./test-ldv-sandbox.mk
	make clean -f ./test-ldv-pkg.mk
	make clean -f ./test-pkg-postgres.mk

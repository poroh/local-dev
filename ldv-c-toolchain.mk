# SPDX-License-Identifier: MIT
#
# C toolchains definitions
#

ifndef ldv-c-toolchain..included
ldv-c-toolchain..included := 1

include $(ldv-root)/ldv-uname.mk
include $(ldv-root)/ldv-vars.mk

# ================================================================================
# Interface

ldv-c-toolchain.tools = $(call ldv-vars.f-get,ldv-c-toolchain..$(ldv-uname.current).tools,C toolchain is not defined for $(ldv-uname.current))

# ================================================================================
# Interface

ldv-c-toolchain..darwin.tools = cc ar as ld install_name_tool ranlib
ldv-c-toolchain..linux.tools = cc ar as ld


endif

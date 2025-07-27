# SPDX-License-Identifier: MIT
#
# Curl routines
#

ifndef ldv-curl--included
ldv-curl--included := 1

include $(ldv-root)/ldv-bin.mk
$(call ldv-bin.f-required,curl)

# ================================================================================
# Interface

# $1 url
# $2 local file
ldv-curl.f-download = $(call ldv-bin.f-exec,curl) -fL '$1' -o '$2'

endif

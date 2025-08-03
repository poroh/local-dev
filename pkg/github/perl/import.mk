# SPDX-License-Identifier: MIT
#
# perl package
#

perl-default-version := v5.42.0
perl-version ?= $(perl-default-version)

ifndef perl..included-$(perl-version)
perl..included-$(perl-version) := 1

include $(ldv-root)/ldv-pkg.mk
include $(ldv-root)/ldv-bin.mk
include $(ldv-root)/ldv-c-toolchain.mk

define perl-descr
  .name      := perl-$(perl-version)
  .version   := $(perl-version)
  .repo-type := github
  .repo-name := Perl/perl5
  .deps      := 
  .makefile  := pkg/github/perl/build.mk
  .makefile-vars :=
  .build-sandbox := $(ldv-c-toolchain.tools) \
                    bash sh cat rm uname make sed touch chmod cp mv grep \
                    mkdir
  .env-path  := bin
endef

$(call ldv-pkg-f-define,perl-descr)

perl.f-pkg = perl-$(if $1,$1,$(perl-version))
perl.f-exec = $(call ldv-pkg.f-prefix,perl-$(if $1,$1,$(perl-version)))/bin/perl
perl.f-path = $(call ldv-pkg.f-prefix,perl-$(if $1,$1,$(perl-version)))/bin

endif

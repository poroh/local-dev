#
# Programs substitution to packages
#

ldv-subst.f-path = $(if $(ldv-subst..$1.path),$(ldv-root)/pkg/$(ldv-subst..$1.path),$(error No idea about package for $1))
ldv-subst.f-pkg = $(if $(ldv-subst..$1.f-pkg),$(call $(ldv-subst..$1.f-pkg)),$(error No idea about package for $1))

# ========================================
# Implementation
#
ldv-subst..bison.path = gnu/bison/import.mk
ldv-subst..bison.f-pkg = gnu-bison.f-pkg

ldv-subst..flex.path = github/flex/import.mk
ldv-subst..flex.f-pkg = flex.f-pkg

ldv-subst..perl.path = github/perl/import.mk
ldv-subst..perl.f-pkg = perl.f-pkg

ldv-subst..pod2man.path = github/perl/import.mk
ldv-subst..pod2man.f-pkg = perl.f-pkg

pkg_name=autoconf
pkg_origin=core
pkg_version=2.69
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Autoconf is an extensible package of M4 macros that produce shell scripts to \
automatically configure software source code packages.\
"
pkg_upstream_url="https://www.gnu.org/software/autoconf/autoconf.html"
pkg_license=('GPL-2.0')
pkg_source="http://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684"
pkg_deps=(
  lilian/m4
  lilian/perl
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/sed
  lilian/gawk
)
pkg_bin_dirs=(bin)

source ../defaults.sh

# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    lilian/gcc/7.1.0/20170624225400
    lilian/coreutils/8.27/20170624233515
    lilian/sed/4.4/20170624233625
    lilian/gawk/4.1.4/20170624234109
    lilian/diffutils/3.6/20170624234540
  )
fi

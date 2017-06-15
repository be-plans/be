pkg_name=automake
pkg_origin=lilian
pkg_version=1.15
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2+')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=9908c75aabd49d13661d6dcb1bc382252d22cc77bf733a2d55e87f2aa2db8636
pkg_deps=(lilian/perl)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/autoconf
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
  pkg_build_deps=(lilian/gcc lilian/coreutils lilian/diffutils lilian/autoconf)
fi

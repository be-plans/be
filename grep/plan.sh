pkg_name=grep
pkg_origin=core
pkg_version=3.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv3+')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=db625c7ab3bb3ee757b3926a5cfa8d9e1c3991ad24707a83dde8a5ef2bf7a07e
pkg_deps=(
  core/glibc
  be/pcre
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
  be/perl
)
pkg_bin_dirs=(bin)

pkg_disabled_features=(lto pic)
source ../defaults.sh

do_check() {
  make check
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc be/coreutils)
fi

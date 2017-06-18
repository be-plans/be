pkg_name=texinfo
pkg_origin=lilian
pkg_version=6.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=246cf3ffa54985118ec2eea2b8d0c71b92114efe6282c2ae90d65029db4cf93a
pkg_deps=(lilian/glibc lilian/ncurses lilian/perl)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/sed
)
pkg_bin_dirs=(bin)

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
  pkg_build_deps=(lilian/gcc lilian/coreutils lilian/sed lilian/diffutils lilian/make lilian/patch)
fi

pkg_origin=core
pkg_name=libmpc
pkg_distname=mpc
pkg_version=1.1.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source=https://ftp.gnu.org/gnu/mpc/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=6985c538143c1208dcb1ac42cedad6ff52e267b47e5f970183a3e75125b43c2e
pkg_deps=(
  core/glibc
  be/gmp
  be/mpfr
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
  be/binutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=${pkg_distname}-${pkg_version}

pkg_disabled_features=(pic)
source ../defaults.sh

do_prepare() {
  do_default_prepare

  export LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  build_line "Updating LDFLAGS=$LDFLAGS"
}

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
  pkg_build_deps=(be/binutils)
fi

pkg_name=mpfr
pkg_origin=core
pkg_version=4.0.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source=http://www.mpfr.org/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=fbe2cd1418b321f5c899ce4f0f0f4e73f5ecc7d02145b0e1fd096f5c3afb8a1d
pkg_deps=(
  core/glibc
  be/gmp
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

pkg_disabled_features=(pic)
source ../defaults.sh

do_prepare() {
  do_default_prepare

  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  build_line "Updating LDFLAGS=$LDFLAGS"
}

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --with-gmp=$(pkg_path_for gmp) \
    --enable-thread-safe \
    --enable-shared

  make -j "$(nproc)"
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

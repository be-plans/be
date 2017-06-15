pkg_origin=lilian
pkg_name=libmpc
pkg_distname=mpc
pkg_version=1.0.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source=http://www.multiprecision.org/mpc/download/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=617decc6ea09889fb08ede330917a00b16809b8db88c29c31bfbb49cbf88ecc3
pkg_deps=(core/glibc lilian/gmp lilian/mpfr)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/binutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=${pkg_distname}-${pkg_version}

source ../better_defaults.sh

do_prepare() {
  do_default_prepare

  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
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
  pkg_build_deps=(lilian/binutils)
fi

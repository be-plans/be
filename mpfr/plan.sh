pkg_name=mpfr
pkg_origin=lilian
pkg_version=3.1.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('lgpl')
pkg_source=http://www.mpfr.org/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=015fde82b3979fbe5f83501986d328331ba8ddf008c1ff3da3c238f49ca062bc
pkg_deps=(core/glibc lilian/gmp)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/binutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../better_defaults.sh

do_prepare() {
  do_default_prepare

  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  build_line "Updating LDFLAGS=$LDFLAGS"
}

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --with-gmp=$(pkg_path_for gmp) \
    --enable-thread-safe
  make -j $(nproc)
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

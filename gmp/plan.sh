pkg_name=gmp
pkg_origin=lilian
pkg_version=6.1.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv3')
pkg_description="GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers."
pkg_upstream_url="https://gmplib.org"
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=87b565e89a9a684fe4ebeeddb8399dce2599f9c9049854ca8c0dfbdea0e21912
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/binutils lilian/m4
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

compiler_flags() {
  local -r optimizations="-O2 -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags

  # Set RUNPATH for c++ compiled code
  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  build_line "Updating LDFLAGS=$LDFLAGS"
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --build=x86_64-unknown-linux-gnu
  make -j"$(nproc)"
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
  pkg_build_deps=(lilian/binutils lilian/m4)
fi

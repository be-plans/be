pkg_name=pcre
pkg_origin=lilian
pkg_version=8.40
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A library that implements Perl 5-style regular expressions"
pkg_upstream_url="http://www.pcre.org/"
pkg_license=('bsd')
pkg_source="https://ftp.pcre.org/pub/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=00e27a29ead4267e3de8111fcaa59b132d0533cdfdbdddf4b0604279acbcf4f4
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

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
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --enable-unicode-properties \
    --enable-utf \
    --enable-pcre16 \
    --enable-pcre32 \
    --enable-jit
  make -j"$(nproc)"
}

do_check() {
  make check
}

do_install() {
  do_default_install

  # Install license file
  install -Dm644 LICENCE "$pkg_prefix/share/licenses/LICENSE"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/coreutils)
fi

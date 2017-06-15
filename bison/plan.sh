pkg_name=bison
pkg_origin=lilian
pkg_version=3.0.4
pkg_description="A parser generator that converts an annotated context-free grammar into a parser"
pkg_upstream_url=https://www.gnu.org/software/bison/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=a72428c7917bdf9fa93cb8181c971b6e22834125848cf1d03ce10b1bb0716fe1
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/m4 lilian/perl
)
pkg_bin_dirs=(bin)

compiler_flags() {
  local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} -Wno-error "
  export CXXFLAGS="${CXXFLAGS} -std=gnu++1z ${optimizations} ${protection} -Wno-error "
  export CPPFLAGS="${CPPFLAGS} -Wno-error "
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags
}

# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/m4 lilian/coreutils)
fi

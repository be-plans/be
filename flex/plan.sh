pkg_name=flex
pkg_origin=lilian
pkg_version=2.6.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('custom')
pkg_source=https://downloads.sourceforge.net/project/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=d39b15a856906997ced252d76e9bfe2425d7503c6ed811669665627b248e4c73
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/m4 lilian/bison
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

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

do_check() {
  # Set `LDFLAGS` for the c++ test code to find libstdc++
  make check LDFLAGS="$LDFLAGS -lstdc++"
}

do_install() {
  do_default_install

  # A few programs do not know about `flex` yet and try to run its predecessor,
  # `lex`
  ln -sv flex $pkg_prefix/bin/lex
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/m4 lilian/coreutils lilian/bison)
fi

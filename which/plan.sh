pkg_origin=lilian
pkg_name=which
pkg_version=2.21
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/which/which-${pkg_version}.tar.gz
pkg_shasum=f4a245b94124b377d8b49646bf421f9155d36aa7614b6ebf83705d3ffc76eaad
pkg_deps=()
pkg_build_deps=(lilian/make lilian/gcc)
pkg_bin_dirs=(bin)

compiler_flags() {
  local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
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

pkg_name=boost
pkg_origin=lilian
pkg_description='Boost provides free peer-reviewed portable C++ source libraries.'
pkg_upstream_url='http://www.boost.org/'
pkg_version=1.64.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Boost Software License')
_pkg_dirname=boost_1_64_0
pkg_source=https://sourceforge.net/projects/boost/files/boost/${pkg_version}/${_pkg_dirname}.tar.bz2
pkg_shasum=7bcc5caace97baa948931d712ea5f37038dbb1c5d89b43ad4def4ed7cb683332
pkg_dirname=${_pkg_dirname}

pkg_deps=(
  core/glibc
  core/gcc-libs
)

pkg_build_deps=(
  core/glibc
  core/gcc-libs
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/python2
  lilian/libxml2
  lilian/libxslt
  lilian/openssl 
  lilian/which
  lilian/zlib
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

compiler_flags() {
  local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} -Wno-error "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} -Wno-error "
  export CPPFLAGS="${CPPFLAGS} -Wno-error "
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags
}

do_build() {
  ./bootstrap.sh --prefix="$pkg_prefix"
}

do_install() {
  export NO_BZIP2=1
  export ZLIB_LIBPATH
  ZLIB_LIBPATH="$(pkg_path_for lilian/zlib)/lib"
  export ZLIB_INCLUDE
  ZLIB_INCLUDE="$(pkg_path_for lilian/zlib)/include"
  ./b2 install --prefix="$pkg_prefix" -q --debug-configuration
}

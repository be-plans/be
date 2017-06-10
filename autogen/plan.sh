pkg_name=autogen
pkg_version=5.18.10
pkg_origin=lilian
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="A tool designed to simplify the creation and maintenance of programs that contain large amounts of repetitious text"
pkg_upstream_url=https://www.gnu.org/software/autogen/
pkg_source="http://ftp.gnu.org/gnu/autogen/rel${pkg_version}/autogen-${pkg_version}.tar.gz"
pkg_shasum=0b8681d9724c481d3b726b5a9e81d3d09dc7f307d1a801c76d0a30d8f843d20a
pkg_deps=(core/glibc core/gcc-libs core/guile core/libxml2 lilian/zlib)
pkg_build_deps=(lilian/gcc lilian/make lilian/pkg-config lilian/diffutils core/which core/perl)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

compiler_flags() {
  local -r optimizations="-O2 -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong -Wformat -Werror=format-security"
  export CFLAGS="${CFLAGS} -std=c11 ${optimizations} ${protection} "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags
}

do_check() {
  make check
}

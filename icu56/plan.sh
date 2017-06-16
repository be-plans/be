pkg_origin=lilian
pkg_name=icu56
pkg_version=56.1
pkg_description="$(cat << EOF
  ICU is a mature, widely used set of C/C++ and Java libraries providing
  Unicode and Globalization support for software applications. ICU is widely
  portable and gives applications the same results on all platforms and
  between C/C++ and Java software.
EOF
)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Unicode-TOU")
# shellcheck disable=SC2059
pkg_source="http://download.icu-project.org/files/icu4c/${pkg_version}/icu4c-$(printf $pkg_version | tr . _)-src.tgz"
pkg_shasum=3a64e9105c734dcf631c0b3ed60404531bce6c0f5a64bfe1a6402a4cc2314816
pkg_upstream_url="http://site.icu-project.org/"
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=icu/source

_compiler_flags() {
  __optimizations="-O2 -DNDEBUG -m64 -mavx"

  export CFLAGS="${CFLAGS} ${__optimizations} "
  export CXXFLAGS="${CXXFLAGS} ${__cxxstd} -std=gnu++1z -fuse-cxa-atexit ${__optimizations} "
  export GCC_CXXFLAGS="${CXXFLAGS} -std=gnu++14 -fuse-cxa-atexit ${__optimizations} "
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_default_prepare() {
  _compiler_flags
}

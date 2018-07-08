pkg_origin=be
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
pkg_deps=(core/glibc lilian/gcc-libs)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=icu/source

# be_generic_flags=" "
# be_optimizations="-O2 -DNDEBUG -m64     "
# be_protection=" "
# be_ldflags=" "
# source ../defaults.sh

_compiler_flags() {
  be_optimizations="-O2 -DNDEBUG -m64 -mavx"
  be_cxxstd="${be_cxxstd:--std=gnu++1z}"
  be_ldflags="${be_ldflags:--Wl,-Bsymbolic-functions -Wl,-z,relro}"

  export CFLAGS="${CFLAGS} ${be_optimizations}"
  export CXXFLAGS="${CXXFLAGS} ${be_cxxstd} -fuse-cxa-atexit ${be_optimizations}"
  export LDFLAGS="${LDFLAGS} ${be_ldflags}"
}

do_default_prepare() {
  _compiler_flags
}

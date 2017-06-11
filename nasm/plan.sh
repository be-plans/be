pkg_name=nasm
pkg_distname=$pkg_name
pkg_origin=lilian
pkg_version=2.13
pkg_description="The Netwide Assembler, NASM, is an 80x86 and x86-64 assembler designed for portability and modularity."
pkg_upstream_url=http://www.nasm.us/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source=http://www.nasm.us/pub/$pkg_distname/releasebuilds/${pkg_version}/$pkg_distname-${pkg_version}.tar.xz
pkg_shasum=ba854c2f02f34f0d6a4611c05e8cb65d9fae8c2b21a4def7fba91a7d67ffde97
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)

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

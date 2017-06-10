pkg_name=bash-completion
pkg_origin=lilian
pkg_version=2.3
pkg_license=('GPLv2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/scop/bash-completion/releases/download/${pkg_version}/bash-completion-${pkg_version}.tar.xz
pkg_shasum=b2e081af317f3da4fff3a332bfdbebeb5514ebc6c2d2a9cf781180acab15e8e9
pkg_bin_dirs=(bin)
pkg_build_deps=(lilian/make lilian/gcc core/autoconf core/automake)
pkg_deps=(core/glibc)

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

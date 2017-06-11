pkg_name=libgcrypt
pkg_origin=lilian
pkg_version=1.7.7
pkg_license=('lgplv2+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=b9b85eba0793ea3e6e66b896eb031fa05e1a4517277cc9ab10816b359254cd9a
pkg_deps=(core/glibc core/libgpg-error)
pkg_build_deps=(
  lilian/gcc lilian/coreutils lilian/sed
  core/bison core/flex lilian/grep core/bash
  core/gawk lilian/libtool lilian/diffutils
  core/findutils lilian/xz lilian/gettext
  lilian/gzip lilian/make lilian/patch
  core/texinfo core/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

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
    --prefix=${pkg_prefix} \
    --enable-static \
    --enable-shared
  make -j $(nproc)
}

do_check() {
  make check
}

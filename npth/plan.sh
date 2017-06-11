pkg_name=npth
pkg_origin=lilian
pkg_version=1.5
pkg_license=('lgplv3+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=294a690c1f537b92ed829d867bee537e46be93fbd60b16c04630fbbfcd9db3c2
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/gcc lilian/coreutils lilian/sed
  lilian/bison lilian/flex lilian/grep
  lilian/bash lilian/gawk lilian/libtool
  lilian/diffutils lilian/findutils lilian/xz
  lilian/gettext lilian/gzip lilian/make
  lilian/patch lilian/texinfo lilian/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../better_defaults.sh

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

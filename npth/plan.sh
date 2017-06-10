pkg_name=npth
pkg_origin=lilian
pkg_version=1.2
pkg_license=('lgplv3+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=6ddbdddb2cf49a4723f9d1ad6563c480d6760dcb63cb7726b8fc3bc2e1b6c08a
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/gcc lilian/coreutils lilian/sed core/bison core/flex core/grep core/bash core/gawk core/libtool lilian/diffutils core/findutils lilian/xz core/gettext core/gzip lilian/make lilian/patch core/texinfo core/util-linux)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure \
    --prefix=${pkg_prefix} \
    --enable-static \
    --enable-shared
  make
}

do_check() {
  make check
}

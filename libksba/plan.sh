pkg_name=libksba
pkg_origin=core
pkg_version=1.3.3
pkg_license=('lgplv3+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=0c7f5ffe34d0414f6951d9880a46fcc2985c487f7c36369b9f11ad41131c7786
pkg_deps=(core/glibc lilian/libgpg-error)
pkg_build_deps=(lilian/gcc lilian/coreutils lilian/sed lilian/bison lilian/flex lilian/grep lilian/bash lilian/gawk lilian/libtool lilian/diffutils lilian/findutils lilian/xz lilian/gettext lilian/gzip lilian/make lilian/patch lilian/texinfo lilian/util-linux)
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

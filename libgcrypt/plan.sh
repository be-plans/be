pkg_name=libgcrypt
pkg_origin=lilian
pkg_version=1.7.7
pkg_license=('lgplv2+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=b9b85eba0793ea3e6e66b896eb031fa05e1a4517277cc9ab10816b359254cd9a
pkg_deps=(core/glibc lilian/libgpg-error)
pkg_build_deps=(
  lilian/gcc lilian/coreutils lilian/sed
  lilian/bison lilian/flex lilian/grep lilian/bash
  lilian/gawk lilian/libtool lilian/diffutils
  lilian/findutils lilian/xz lilian/gettext
  lilian/gzip lilian/make lilian/patch
  lilian/texinfo lilian/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

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

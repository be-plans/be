pkg_name=libgcrypt
pkg_origin=core
pkg_version=1.8.2
pkg_license=('lgplv2+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=c8064cae7558144b13ef0eb87093412380efa16c4ee30ad12ecb54886a524c07
pkg_deps=(
  core/glibc
  lilian/libgpg-error
)
pkg_build_deps=(
  be/gcc
  be/coreutils
  be/sed
  be/bison
  lilian/flex
  be/grep
  lilian/bash
  be/gawk
  lilian/libtool
  be/diffutils
  lilian/findutils
  be/xz
  lilian/gettext
  lilian/gzip
  be/make
  be/patch
  lilian/texinfo
  lilian/util-linux
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

pkg_name=dpkg
pkg_origin=core
pkg_version=1.18.24
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_upstream_url=https://wiki.debian.org/dpkg
pkg_description="dpkg is a package manager for Debian-based systems"
pkg_source=http://http.debian.net/debian/pool/main/d/${pkg_name}/${pkg_name}_${pkg_version}.tar.xz
pkg_shasum=d853081d3e06bfd46a227056e591f094e42e78fa8a5793b0093bad30b710d7b4
pkg_deps=(
  be/bzip2
  core/glibc
  lilian/tar
  be/zlib
  be/xz
)
pkg_build_deps=(
  lilian/autoconf
  lilian/automake
  be/bzip2
  be/gcc
  lilian/gettext
  lilian/libtool
  be/patch
  be/make
  be/ncurses
  be/perl
  be/pkg-config
  be/patch
  be/xz
  be/zlib
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

be_cxxstd="-std=gnu++14"
source ../defaults.sh

do_build() {
  export prefix=$pkg_prefix
  do_default_build
}

do_install() {
  export prefix=$pkg_prefix
  do_default_install
}

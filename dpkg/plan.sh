pkg_name=dpkg
pkg_origin=lilian
pkg_version=1.18.24
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_upstream_url=https://wiki.debian.org/dpkg
pkg_description="dpkg is a package manager for Debian-based systems"
pkg_source=http://http.debian.net/debian/pool/main/d/${pkg_name}/${pkg_name}_${pkg_version}.tar.xz
pkg_shasum=d853081d3e06bfd46a227056e591f094e42e78fa8a5793b0093bad30b710d7b4
pkg_deps=(
  lilian/bzip2
  core/glibc
  lilian/tar
  lilian/zlib
  lilian/xz
)
pkg_build_deps=(
  lilian/autoconf
  lilian/automake
  lilian/bzip2
  lilian/gcc
  lilian/gettext
  lilian/libtool
  lilian/make
  lilian/ncurses
  lilian/perl
  lilian/pkg-config
  lilian/patch
  lilian/xz
  lilian/zlib
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../better_defaults.sh

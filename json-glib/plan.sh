pkg_name=json-glib
pkg_origin=core
pkg_version="1.2.8"
pkg_description="A library for reading and parsing JSON using GLib and GObject data types and API"
pkg_upstream_url="https://developer.gnome.org/json-glib/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=fd55a9037d39e7a10f0db64309f5f0265fa32ec962bf85066087b83a2807f40a
pkg_deps=(
  core/glib
  core/glibc
  lilian/libffi
  core/libxslt
  be/libiconv
  be/pcre
  be/util-linux
  be/zlib
)
pkg_build_deps=(
  be/diffutils
  be/gcc
  be/gettext
  be/make
  be/perl
  be/pkg-config
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  make check
}

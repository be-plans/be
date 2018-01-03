pkg_name=pango
pkg_origin=core
pkg_version="1.40.13"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="f84e98db1078772ff4935b40a1629ff82ef0dfdd08d2cbcc0130c8c437857196"
pkg_upstream_url="http://www.pango.org"
pkg_description="Pango is a library for laying out and rendering of text, with an emphasis on internationalization."
pkg_deps=(
  lilian/bzip2
  lilian/cairo
  be/coreutils
  lilian/expat
  lilian/fontconfig
  lilian/freetype
  lilian/glib
  core/glibc
  lilian/harfbuzz
  lilian/libffi
  lilian/libiconv
  lilian/libpng
  lilian/libxau
  lilian/libxcb
  lilian/libxdmcp
  lilian/libxext
  lilian/pcre
  lilian/pixman
  lilian/xlib
  lilian/zlib
)
pkg_build_deps=(
  lilian/file
  be/gcc
  be/make
  lilian/perl
  lilian/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/pango-1.0/pango)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  if [ ! -e /usr/bin/file ]
  then
    ln -sv "$(pkg_path_for lilian/file)/bin/file" /usr/bin/file
  fi
}

do_build() {
  ./configure --prefix="$pkg_prefix"

  make -j "$(nproc)"
}
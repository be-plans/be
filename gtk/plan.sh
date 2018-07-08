pkg_name=gtk
pkg_origin=core
pkg_version=3.22.22
pkg_description="GTK+, or the GIMP Toolkit, is a multi-platform toolkit for creating graphical user interfaces."
pkg_upstream_url="https://www.gtk.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
upstream_name="gtk+"
pkg_source="https://download.gnome.org/sources/${upstream_name}/${pkg_version%.*}/${upstream_name}-${pkg_version}.tar.xz"
pkg_shasum=862dc22c5e93cd800753e5e90dfdb3af0fc760a47f6ebd918ae19136d527c6cd
pkg_dirname="${upstream_name}-${pkg_version}"
pkg_deps=(
  lilian/at-spi2-core
  lilian/at-spi2-atk
  lilian/atk
  lilian/bzip2
  lilian/cairo
  lilian/dbus
  lilian/expat
  lilian/fontconfig
  lilian/freetype
  lilian/gcc-libs
  lilian/gdk-pixbuf
  lilian/glib
  core/glibc
  lilian/harfbuzz
  lilian/libepoxy
  lilian/libffi
  lilian/libice
  lilian/libiconv
  lilian/libpng
  lilian/libsm
  lilian/libxau
  lilian/libxcb
  lilian/libxdmcp
  lilian/libxext
  lilian/libxfixes
  lilian/libxi
  lilian/pango
  lilian/pcre
  lilian/pixman
  lilian/util-linux
  lilian/xlib
  lilian/zlib
)
pkg_build_deps=(
  lilian/diffutils
  lilian/file
  lilian/fixesproto
  lilian/gcc
  lilian/gettext
  lilian/inputproto
  lilian/json-glib
  lilian/kbproto
  lilian/libpthread-stubs
  lilian/libxslt
  lilian/make
  lilian/papi
  lilian/perl
  lilian/pkg-config
  lilian/renderproto
  lilian/xextproto
  lilian/xproto
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --disable-xinerama
  make
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

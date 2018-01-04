pkg_name=gtk2
pkg_origin=core
pkg_version=2.24.31
pkg_description="GTK+, or the GIMP Toolkit, is a multi-platform toolkit for creating graphical user interfaces."
pkg_upstream_url="https://www.gtk.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
upstream_name="gtk+"
pkg_source="https://download.gnome.org/sources/${upstream_name}/${pkg_version%.*}/${upstream_name}-${pkg_version}.tar.xz"
pkg_shasum=68c1922732c7efc08df4656a5366dcc3afdc8791513400dac276009b40954658
pkg_dirname="${upstream_name}-${pkg_version}"
pkg_deps=(
  lilian/atk
  be/bzip2
  lilian/cairo
  be/expat
  lilian/fontconfig
  lilian/freetype
  core/gcc-libs
  lilian/gdk-pixbuf
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
  lilian/libxrender
  lilian/pango
  be/pcre
  lilian/pixman
  lilian/util-linux
  lilian/xlib
  be/zlib
)
pkg_build_deps=(
  be/gcc
  lilian/kbproto
  be/make
  be/perl
  be/pkg-config
  lilian/renderproto
  lilian/shared-mime-info
  lilian/xextproto
  lilian/xproto
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  do_default_prepare

  XDG_DATA_DIRS="$XDG_DATA_DIRS:$(pkg_path_for lilian/shared-mime-info)/share"
  export XDG_DATA_DIRS
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --disable-glibtest \
    --disable-xinerama
  make
}

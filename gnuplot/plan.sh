pkg_name=gnuplot
pkg_origin=core
pkg_version="5.2.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gnuplot')
pkg_source="https://sourceforge.net/projects/$pkg_name/files/$pkg_name/$pkg_version/$pkg_name-$pkg_version.tar.gz"
pkg_shasum="a416d22f02bdf3873ef82c5eb7f8e94146795811ef808e12b035ada88ef7b1a1"
pkg_deps=(
  lilian/bzip2
  lilian/cairo
  lilian/expat
  lilian/fontconfig
  lilian/freetype
  lilian/gcc-libs
  lilian/glib
  core/glibc
  lilian/harfbuzz
  lilian/jbigkit
  lilian/libcerf
  lilian/liberation-fonts-ttf
  lilian/libffi
  lilian/libice
  lilian/libiconv
  lilian/libgd
  lilian/libjpeg-turbo
  lilian/libpng
  lilian/libsm
  lilian/libtiff
  lilian/libxau
  lilian/libxcb
  lilian/libxdmcp
  lilian/libxext
  lilian/ncurses
  lilian/pango
  lilian/pcre
  lilian/pixman
  lilian/readline
  lilian/xlib
  lilian/xz
  lilian/zlib
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
  lilian/patch
  lilian/pkg-config
)
pkg_bin_dirs=(bin)
pkg_upstream_url="http://www.gnuplot.info"
pkg_description="Gnuplot is a portable command-line driven graphing
utility for Linux, OS/2, MS Windows, OSX, VMS, and many other
platforms"

do_prepare() {
  patch -p1 -i "$PLAN_CONTEXT/patches/configure-using-pkgconfig.patch"
}

do_check() {
  make check
}

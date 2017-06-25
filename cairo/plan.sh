pkg_name=cairo
pkg_origin=lilian
pkg_version="1.14.10"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(
  'LGPL-2.1'
  'MPL-1.1'
)
pkg_source="https://www.cairographics.org/releases/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=7e87878658f2c9951a14fc64114d4958c0e65ac47530b8ac3078b2ce41b66a09
pkg_description="Cairo is a 2D graphics library with support for multiple output devices."
pkg_upstream_url="https://www.cairographics.org"
pkg_deps=(
  lilian/expat
  lilian/fontconfig
  lilian/freetype
  lilian/glib
  lilian/libpng
  lilian/pcre
  lilian/pixman
  lilian/zlib
)
pkg_build_deps=(
  lilian/diffutils
  lilian/gcc
  lilian/make
  lilian/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/cairo)
pkg_lib_dirs=(
  lib
  lib/cairo
)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_build() {
  # CFLAGS="-Os ${CFLAGS}"

  ./configure --prefix="${pkg_prefix}" \
              --disable-xlib
  
  make -j "$(nproc)"
}

do_check() {
  make test
}

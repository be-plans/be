pkg_name=cairo
pkg_origin=core
pkg_version="1.14.10"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(
  "LGPL-2.1"
  "MPL-1.1"
)
pkg_source="https://www.cairographics.org/releases/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=7e87878658f2c9951a14fc64114d4958c0e65ac47530b8ac3078b2ce41b66a09
pkg_description="Cairo is a 2D graphics library with support for multiple output devices."
pkg_upstream_url="https://www.cairographics.org"
pkg_deps=(
  be/bzip2
  be/expat
  lilian/fontconfig
  lilian/freetype
  be/gcc-libs
  lilian/glib
  core/glibc
  lilian/libffi
  lilian/libice
  be/libiconv
  lilian/libpng
  lilian/libsm
  lilian/libxau
  lilian/libxcb
  lilian/libxdmcp
  lilian/libxext
  lilian/lzo
  be/pcre
  lilian/pixman
  lilian/xlib
  be/zlib
)
pkg_build_deps=(
  be/diffutils
  be/file
  be/gcc
  be/make
  be/pkg-config
  lilian/xextproto
  lilian/xproto
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(
  lib
  lib/cairo
)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
  fi
}

do_build() {
  # CFLAGS="-Os ${CFLAGS}"

  ./configure --prefix="${pkg_prefix}" \
              --enable-xlib

  make -j "$(nproc)"
}

do_check() {
  make test
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

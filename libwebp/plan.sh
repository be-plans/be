pkg_name=libwebp
pkg_version=0.5.1
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('WebM') # Custom BSD3-like license, see: https://www.webmproject.org/license/software/
pkg_description="WebP codec: library to encode and decode images in WebP format."
pkg_upstream_url=https://developers.google.com/speed/webp
pkg_source=https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=6ad66c6fcd60a023de20b6856b03da8c7d347269d76b1fd9c3287e8b5e8813df
pkg_deps=(
  lilian/giflib
  core/glibc
  lilian/libjpeg-turbo
  lilian/jbigkit
  lilian/libpng
  lilian/libtiff
  lilian/xz
  lilian/zlib
)
pkg_build_deps=(
  lilian/gcc
  lilian/file
  lilian/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure --prefix="$pkg_prefix" --enable-libwebpmux --enable-libwebpdemux --enable-libwebpdecoder
  make
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

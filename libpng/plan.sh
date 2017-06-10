pkg_name=libpng
pkg_version=1.6.21
pkg_origin=lilian
pkg_license=('libpng')
pkg_description="An Open, Extensible Image Format with Lossless Compression"
pkg_upstream_url=http://www.libpng.org/pub/png/
pkg_source=http://download.sourceforge.net/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=b36a3c124622c8e1647f360424371394284f4c6c4b384593e478666c59ff42d3
pkg_deps=(core/glibc lilian/zlib)
pkg_build_deps=(lilian/gcc lilian/make lilian/coreutils lilian/diffutils
                core/autoconf core/automake)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  _zlib_dir=$(pkg_path_for zlib)

  ./configure --prefix="${pkg_prefix}" \
              --host=x86_64-unknown-linux-gnu \
              --build=x86_64-unknown-linux-gnu \
              --disable-static \
              --with-zlib-prefix="${_zlib_dir}"
  make
}

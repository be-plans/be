pkg_name=libpng
pkg_version=1.6.29
pkg_origin=lilian
pkg_license=('libpng')
pkg_description="An Open, Extensible Image Format with Lossless Compression"
pkg_upstream_url=http://www.libpng.org/pub/png/
pkg_source=http://download.sourceforge.net/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz
pkg_filename=${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=4245b684e8fe829ebb76186327bb37ce5a639938b219882b53d64bd3cfc5f239
pkg_deps=(lilian/glibc lilian/zlib)
pkg_build_deps=(
  lilian/gcc lilian/make lilian/coreutils
  lilian/diffutils lilian/autoconf lilian/automake)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  _zlib_dir=$(pkg_path_for zlib)

  ./configure --prefix="${pkg_prefix}" \
              --host=x86_64-unknown-linux-gnu \
              --build=x86_64-unknown-linux-gnu \
              --disable-static \
              --with-zlib-prefix="${_zlib_dir}"
  make -j $(nproc)
}

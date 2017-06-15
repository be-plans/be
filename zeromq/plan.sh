pkg_name=zeromq
pkg_origin=lilian
pkg_version=4.1.4
pkg_license=('LGPL')
pkg_source=http://download.zeromq.org/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=e99f44fde25c2e4cb84ce440f87ca7d3fe3271c2b8cfbc67d55e4de25e6fe378
pkg_deps=(core/glibc core/gcc-libs lilian/libsodium)
pkg_build_deps=(lilian/gcc lilian/coreutils lilian/make lilian/pkg-config lilian/patchelf)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_default_build() {
  ./configure --prefix="${pkg_prefix:?}"
  make -j $(nproc)
}

do_install() {
  do_default_install
  find $pkg_prefix/lib -name *.so | xargs -I '%' patchelf --set-rpath "$LD_RUN_PATH" %
}

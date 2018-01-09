pkg_name=zeromq
pkg_origin=core
pkg_version=4.2.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="ZeroMQ core engine in C++, implements ZMTP/3.0"
pkg_upstream_url=http://zeromq.org
pkg_license=('LGPL')
pkg_source=https://github.com/zeromq/libzmq/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=8f1e2b2aade4dbfde98d82366d61baef2f62e812530160d2e6d0a5bb24e40bc0
pkg_deps=(
  core/glibc
  be/gcc-libs
  be/libsodium
)
pkg_build_deps=(
  be/gcc
  be/coreutils
  be/make
  be/pkg-config
  be/patchelf
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_install() {
  do_default_install
    # shellcheck disable=SC2038
  find "$pkg_prefix/lib" -name "*.so" | xargs -I '%' patchelf --set-rpath "$LD_RUN_PATH" %
}

pkg_name=jemalloc
pkg_description="malloc implementation emphasizing fragmentation avoidance"
pkg_upstream_url="http://jemalloc.net/"
pkg_origin=be
pkg_version=5.0.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source=https://github.com/jemalloc/jemalloc/releases/download/$pkg_version/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=9e4a9efba7dc4a7696f247c90c3fe89696de5f910f7deacf7e22ec521b1fa810
pkg_dirname=${pkg_name}-${pkg_version}
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(
  lilian/gcc
  lilian/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

no_pie=true
source ../defaults.sh

do_check() {
  make check
}

do_install() {
  # Default `install` includes doc that we do not need
  make install_bin install_include install_lib
  install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}

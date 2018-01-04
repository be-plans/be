pkg_name=bdwgc
pkg_origin=core
pkg_version=7.6.2
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.hboehm.info/gc/gc_source/gc-${pkg_version}.tar.gz"
pkg_shasum=bd112005563d787675163b5afff02c364fc8deb13a99c03f4e80fdf6608ad41e
pkg_deps=(
  core/glibc
  be/libatomic_ops
)
pkg_build_deps=(
  be/gcc
  be/make
  be/cmake
  be/diffutils
  be/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname="gc-${pkg_version}"

source ../defaults.sh

do_default_build() {
  ./configure --prefix="${pkg_prefix:?}"
  make -j $(nproc)
}

do_check() {
  make check
}

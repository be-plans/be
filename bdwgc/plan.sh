pkg_name=bdwgc
pkg_origin=be
pkg_version=7.6.0
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.hboehm.info/gc/gc_source/gc-${pkg_version}.tar.gz"
pkg_shasum=a14a28b1129be90e55cd6f71127ffc5594e1091d5d54131528c24cd0c03b7d90
pkg_deps=(core/glibc lilian/libatomic_ops)
pkg_build_deps=(lilian/gcc lilian/make lilian/cmake lilian/diffutils lilian/pkg-config)
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

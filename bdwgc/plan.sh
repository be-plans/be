pkg_name=bdwgc
pkg_origin=core
pkg_version=7.6.2
pkg_description="A garbage collector for C and C++"
pkg_upstream_url="http://www.hboehm.info/gc/"
pkg_license=('X11 style license')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.hboehm.info/gc/gc_source/gc-${pkg_version}.tar.gz"
pkg_dirname="gc-${pkg_version}"
pkg_shasum=bd112005563d787675163b5afff02c364fc8deb13a99c03f4e80fdf6608ad41e
pkg_deps=(
  core/glibc
  lilian/libatomic_ops
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
  lilian/cmake
  lilian/diffutils
  lilian/pkg-config
)

pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

source ../defaults.sh

do_default_build() {
  ./configure --prefix="${pkg_prefix:?}"
  make -j $(nproc)
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

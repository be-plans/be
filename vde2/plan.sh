pkg_name=vde2
pkg_origin=core
pkg_version=2.3.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="VDE is an ethernet compliant virtual network that can be spawned over a set of physical computer over the Internet."
pkg_license=("GPL-2.0")
pkg_upstream_url="http://vde.sourceforge.net/"
pkg_source=https://downloads.sourceforge.net/vde/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=cbea9b7e03097f87a6b5e98b07890d2275848f1fe4b9fcda77b8994148bc9542
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_deps=(
  be/bash
  core/glibc
  core/gcc-libs
  lilian/libpcap
  be/openssl
)
pkg_build_deps=(
  be/make
  be/gcc
  core/gcc-libs
  core/glibc
  lilian/python2
)

source ../defaults.sh

do_build() {
  ./configure --prefix="${pkg_prefix}" --enable-experimental
  make
}

pkg_origin=lilian
pkg_name=libevent
pkg_version=2.1.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source=https://github.com/${pkg_name}/${pkg_name}/releases/download/release-${pkg_version}-stable/${pkg_name}-${pkg_version}-stable.tar.gz
pkg_shasum=965cc5a8bb46ce4199a47e9b2c9e1cae3b137e8356ffdad6d94d3b9069b71dc2
pkg_dirname=${pkg_name}-${pkg_version}-stable
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/cacerts lilian/gcc lilian/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

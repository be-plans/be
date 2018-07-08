pkg_name=dosfstools
pkg_origin=core
pkg_version="4.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="e6b2aca70ccc3fe3687365009dd94a2e18e82b688ed4e260e04b7412471cc173"
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/make lilian/gcc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

source ../defaults.sh

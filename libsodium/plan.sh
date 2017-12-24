pkg_name=libsodium
pkg_distname=$pkg_name
pkg_origin=be
pkg_version=1.0.13
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('libsodium')
pkg_source=https://download.libsodium.org/libsodium/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=9c13accb1a9e59ab3affde0e60ef9a2149ed4d6e8f99c93c7a5b97499ee323fd
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/autoconf lilian/automake lilian/diffutils
  lilian/patch lilian/make lilian/gcc lilian/sed
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

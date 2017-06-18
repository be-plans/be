pkg_name=libsodium
pkg_distname=$pkg_name
pkg_origin=lilian
pkg_version=1.0.12
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('libsodium')
pkg_source=https://download.libsodium.org/libsodium/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=b8648f1bb3a54b0251cf4ffa4f0d76ded13977d4fa7517d988f4c902dd8e2f95
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(lilian/glibc)
pkg_build_deps=(
  lilian/autoconf lilian/automake lilian/diffutils
  lilian/patch lilian/make lilian/gcc lilian/sed
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

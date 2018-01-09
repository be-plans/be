pkg_name=libsodium
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=1.0.16
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('libsodium')
pkg_source=https://download.libsodium.org/libsodium/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  be/autoconf
  be/automake
  be/diffutils
  be/patch
  be/make
  be/gcc
  be/sed
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

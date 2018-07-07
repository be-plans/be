pkg_name=libsodium
_distname="$pkg_name"
pkg_origin=core
pkg_version=1.0.13
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Sodium is a new, easy-to-use software library for encryption, decryption, \
signatures, password hashing and more. It is a portable, cross-compilable, \
installable, packageable fork of NaCl, with a compatible API, and an extended \
API to improve usability even further.\
"
pkg_upstream_url="https://github.com/jedisct1/libsodium"
pkg_license=('libsodium')
pkg_source="https://download.libsodium.org/libsodium/releases/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="9c13accb1a9e59ab3affde0e60ef9a2149ed4d6e8f99c93c7a5b97499ee323fd"
pkg_dirname="${_distname}-${pkg_version}"
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
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_check() {
  make check
}

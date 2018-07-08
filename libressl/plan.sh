pkg_name=libressl
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=2.6.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Version of the TLS/crypto stack forked from OpenSSL"
pkg_license=('OpenSSL')
pkg_upstream_url=http://www.libressl.org/
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_source=http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${pkg_dirname}.tar.gz
pkg_shasum=638a20c2f9e99ee283a841cd787ab4d846d1880e180c4e96904fc327d419d11f
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  lilian/diffutils
  lilian/file
  lilian/make
  lilian/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  export CC=gcc
  build_line "Setting CC=$CC"
}

do_check() {
  make check
}

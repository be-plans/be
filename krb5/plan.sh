pkg_origin=lilian
pkg_name=krb5
pkg_version=1.15.1
pkg_description="Kerberos is a network authentication protocol. It is designed
  to provide strong authentication for client/server applications by using
  secret-key cryptography. "
pkg_upstream_url=http://web.mit.edu/kerberos/www/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source="http://web.mit.edu/kerberos/dist/$pkg_name/${pkg_version%.*}/$pkg_name-$pkg_version.tar.gz"
pkg_shasum=437c8831ddd5fde2a993fef425dedb48468109bb3d3261ef838295045a89eb45
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  lilian/bison
  lilian/busybox
  lilian/gcc
  lilian/m4
  lilian/make
  lilian/perl
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

#TODO: This was not built
source ../defaults.sh

do_build() {
  cd src || exit
  do_default_build
}

do_install() {
  cd src || exit
  do_default_install
}

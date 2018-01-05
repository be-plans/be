pkg_origin=core
pkg_name=openssh
pkg_version=7.6p1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Provides OpenSSH client and server."
pkg_license=('BSD')
pkg_source=http://ftp3.usa.openbsd.org/pub/OpenBSD/OpenSSH/portable/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=a323caeeddfe145baaa0db16e98d784b1fbc7dd436a6bf1f479dfd5cd1d21723
pkg_upstream_url=https://www.openssh.com/
pkg_bin_dirs=(bin sbin libexec)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_deps=(
  core/glibc
  be/openssl
  be/zlib
)
pkg_build_deps=(
  be/coreutils
  be/gcc
  be/make
)

pkg_svc_user="root"
pkg_svc_group="root"

source ../defaults.sh

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --sysconfdir="${pkg_svc_path}/config" \
              --localstatedir="${pkg_svc_path}/var" \
              --datadir="${pkg_svc_data_path}" \
              --with-privsep-user=hab \
              --with-privsep-path="${pkg_prefix}/var/empty"
  make -j $(nproc)
}

do_install() {
  make install-nosysconf
  mkdir -p "${pkg_prefix}/var/empty"
  chmod 700 "${pkg_prefix}/var/empty"
}

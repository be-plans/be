pkg_origin=lilian
pkg_name=openssh
pkg_version=7.2p2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Provides OpenSSH client and server."
pkg_license=('bsd')
pkg_source=http://ftp3.usa.openbsd.org/pub/OpenBSD/OpenSSH/portable/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=a72781d1a043876a224ff1b0032daa4094d87565a68528759c1c2cab5482548c
pkg_upstream_url=https://www.openssh.com/
pkg_bin_dirs=(bin sbin libexec)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_deps=(core/glibc lilian/openssl  lilian/zlib)
pkg_build_deps=(lilian/coreutils lilian/gcc lilian/make)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --sysconfdir="${pkg_svc_path}/config" \
              --localstatedir="${pkg_svc_path}/var" \
              --datadir="${pkg_svc_data_path}" \
              --with-privsep-user=hab \
              --with-privsep-path="${pkg_prefix}/var/empty"
  make
}

do_install() {
  make install-nosysconf
  mkdir -p "${pkg_prefix}/var/empty"
  chmod 700 "${pkg_prefix}/var/empty"
}

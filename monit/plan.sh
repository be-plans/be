pkg_name=monit
pkg_origin=core
pkg_version="5.25.1"
pkg_upstream_url="https://mmonit.com/monit"
pkg_description="Monit. Barking at daemons"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('AGPL-3.0')
pkg_source="https://mmonit.com/monit/dist/monit-${pkg_version}.tar.gz"
pkg_shasum="4b5c25ceb10825f1e5404f1d8a7b21507716b82bc20c3586f86603691c3b81bc"
pkg_deps=(
  be/bash
  core/glibc
  be/openssl
  be/zlib
)
pkg_build_deps=(
  be/diffutils
  be/gcc
  be/make
)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root

do_build() {
    ./configure --prefix="$pkg_prefix" \
                --enable-optimized \
                --without-pam \
                --with-ssl-incl-dir="$(pkg_path_for be/openssl)/include"
    make
}

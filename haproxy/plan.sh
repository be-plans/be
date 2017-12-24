pkg_origin=be
pkg_name=haproxy
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_version=1.7.6
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_upstream_url="http://git.haproxy.org/git/haproxy-1.7.git/"
pkg_source=http://www.haproxy.org/download/1.7/src/haproxy-${pkg_version}.tar.gz
pkg_shasum=88f84beba34d08a5495d908ca76866e033e6046e7c74f9477b9d5316f8c3d32a
pkg_svc_run='haproxy -f config/haproxy.conf -db'
pkg_exports=(
  [port]=front-end.port
  [status-port]=status.port
)
pkg_exposes=(port status-port)
pkg_binds=(
  [backend]="port"
)
pkg_deps=(lilian/zlib lilian/pcre lilian/openssl)
pkg_build_deps=(
  lilian/coreutils
  lilian/gcc
  lilian/pcre
  lilian/make
  lilian/openssl
  lilian/zlib
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  make -j "$(nproc)" \
    USE_PCRE=1 \
    USE_PCRE_JIT=1 \
    TARGET=linux2628 \
    USE_OPENSSL=1 \
    USE_ZLIB=1 \
    ADDINC="$CFLAGS" \
    ADDLIB="$LDFLAGS"
}

do_install() {
  mkdir -p "$pkg_prefix"/bin
  cp haproxy "$pkg_prefix"/bin
}

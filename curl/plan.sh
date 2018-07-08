pkg_name=curl
pkg_origin=core
pkg_version=7.57.0
pkg_description="curl is an open source command line tool and library for
  transferring data with URL syntax."
pkg_upstream_url=https://curl.haxx.se/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('curl')
pkg_source=https://curl.haxx.se/download/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=f5f6fd3c72b7b8389969f4fb671ed8532fa9b5bb7a5cae7ca89bc1cea45c7878
pkg_deps=(
  lilian/cacerts
  core/glibc
  lilian/openssl
  lilian/zlib
  lilian/nghttp2
)
pkg_build_deps=(
  lilian/coreutils
  lilian/gcc
  lilian/make
  lilian/perl
  lilian/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  # Patch the zsh-generating program to use our perl at build time
  sed -i "s,/usr/bin/perl,$(pkg_path_for perl)/bin/perl,g" scripts/zsh.pl
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
              --with-ca-bundle="$(pkg_path_for cacerts)/ssl/certs/cacert.pem" \
              --with-ssl="$(pkg_path_for openssl)" \
              --with-zlib="$(pkg_path_for zlib)" \
              --with-nghttp2="$(pkg_path_for nghttp2)" \
              --disable-manual \
              --disable-ldap \
              --disable-ldaps \
              --disable-rtsp \
              --enable-proxy \
              --enable-optimize \
              --disable-dependency-tracking \
              --enable-ipv6 \
              --without-libidn \
              --without-gnutls \
              --without-librtmp
  make -j $(nproc)
}

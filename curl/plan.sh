pkg_name=curl
pkg_origin=lilian
pkg_version=7.54.1
pkg_description="curl is an open source command line tool and library for
  transferring data with URL syntax."
pkg_upstream_url=https://curl.haxx.se/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('curl')
pkg_source=https://curl.haxx.se/download/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=fdfc4df2d001ee0c44ec071186e770046249263c491fcae48df0e1a3ca8f25a0
pkg_deps=(
  lilian/cacerts
  lilian/glibc
  lilian/openssl 
  lilian/zlib
)
pkg_build_deps=(
  lilian/coreutils
  lilian/gcc
  lilian/make
  lilian/perl
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

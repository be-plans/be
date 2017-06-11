pkg_name=curl
pkg_origin=lilian
pkg_version=7.54.0
pkg_description="curl is an open source command line tool and library for
  transferring data with URL syntax."
pkg_upstream_url=https://curl.haxx.se/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('curl')
pkg_source=https://curl.haxx.se/download/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=f50ebaf43c507fa7cc32be4b8108fa8bbd0f5022e90794388f3c7694a302ff06
pkg_deps=(
  core/cacerts
  core/glibc
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

source ../better_defaults.sh

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

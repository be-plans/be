pkg_name=gnutls
pkg_origin=core
pkg_version="3.5.18"
pkg_description="GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them"
pkg_upstream_url="https://www.gnutls.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1-or-later')
pkg_source="ftp://ftp.gnutls.org/gcrypt/gnutls/v3.5/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="ae2248d9e78747cf9c469dde81ff8f90b56838b707a0637f3f7d4eee90e80234"
pkg_deps=(
  core/glibc
  lilian/gmp
  lilian/guile
  lilian/libiconv
  lilian/libidn2
  lilian/libseccomp
  lilian/libtasn1
  lilian/libunistring
  lilian/nettle
  lilian/p11-kit
  lilian/zlib
)
pkg_build_deps=(
  lilian/autogen
  lilian/bison
  lilian/diffutils
  lilian/file
  lilian/gettext
  lilian/gcc
  lilian/iproute2
  lilian/make
  lilian/pkg-config
  lilian/which
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure --prefix="${pkg_prefix}" \
    --with-libseccomp-prefix="$(pkg_path_for "lilian/libseccomp")" \
    --with-libiconv-prefix="$(pkg_path_for "lilian/libiconv")" \
    --with-libunistring-prefix="$(pkg_path_for "lilian/libunistring")" \
    --disable-valgrind-tests
  make -j"$(nproc)"
}

do_check() {
  # two tests fail
  # 1. a pkg config test which sets the PKG_CONFIG_PATH without nettle in it, would need to modify the test
  # 2. a libgcc_s.so.1 not found for one test, modifying LD_* variables does not seem to help
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

pkg_origin=be
pkg_name=gnutls
pkg_version=3.5.13
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPLv2.1+')
pkg_description="GnuTLS is a secure communications library implementing the SSL, TLS and DTLS "\
"protocols and technologies around them."
pkg_upstream_url=http://www.gnutls.org
pkg_source=https://www.gnupg.org/ftp/gcrypt/${pkg_name}/v3.5/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=79f5480ad198dad5bc78e075f4a40c4a315a1b2072666919d2d05a08aec13096
pkg_deps=(
  core/glibc lilian/nettle lilian/gmp
  lilian/libtasn1 lilian/libunistring lilian/libidn2
  lilian/unbound
)
pkg_build_deps=(
  be/gcc lilian/make lilian/pkg-config
  lilian/diffutils lilian/coreutils lilian/p11-kit
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include include/gnutls)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

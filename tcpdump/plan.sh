pkg_name=tcpdump
pkg_origin=lilian
pkg_version=4.7.4
pkg_description="A powerful command-line packet analyzer."
pkg_upstream_url="http://www.tcpdump.org/"
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://www.tcpdump.org/release/tcpdump-${pkg_version}.tar.gz
pkg_shasum=6be520269a89036f99c0b2126713a60965953eab921002b07608ccfc0c47d9af
# lilian/coreutils isn't /really/ needed at runtime, but fix_interpreter
# only works if the dep is listed in pkg_deps
pkg_deps=(core/glibc core/libpcap lilian/openssl  lilian/coreutils)
pkg_build_deps=(lilian/gcc lilian/make lilian/perl lilian/diffutils)
pkg_bin_dirs=(sbin)

do_build() {
  ./configure --prefix="$pkg_prefix" --with-crypto
  make -j "$(nproc)"
}

do_check() {
  fix_interpreter "tests/TESTonce" lilian/coreutils bin/env
  make check
}

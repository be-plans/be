pkg_name=libgcrypt
pkg_origin=core
pkg_version=1.7.10
pkg_license=('lgplv2+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=89f05a423dd66a25e5b38308097e2386e640d1cf835160d19a5c75350071d94c
pkg_deps=(
  core/glibc
  lilian/libgpg-error
)
pkg_build_deps=(
  lilian/gcc
  lilian/coreutils
  lilian/sed
  lilian/bison
  lilian/flex
  lilian/grep
  lilian/bash
  lilian/gawk
  lilian/libtool
  lilian/diffutils
  lilian/findutils
  lilian/xz
  lilian/gettext
  lilian/gzip
  lilian/make
  lilian/patch
  lilian/texinfo
  lilian/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url="https://www.gnupg.org/software/libgcrypt/index.html"
pkg_description="Libgcrypt is a general purpose cryptographic library originally based on code from GnuPG."

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-static \
    --enable-shared
  make -j $(nproc)
}

do_check() {
  make check
}

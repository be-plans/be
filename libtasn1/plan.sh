pkg_name=libtasn1
pkg_origin=core
pkg_version="4.13"
pkg_description="ASN.1 implementation"
pkg_upstream_url="https://www.gnu.org/software/libtasn1/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1-or-later')
pkg_source="https://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="7e528e8c317ddd156230c4e31d082cd13e7ddeb7a54824be82632209550c8cca"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  be/bison
  be/busybox-static
  be/diffutils
  be/file
  be/gcc
  be/make
  be/pkg-config
  be/util-linux
)

pkg_bin_dirs=(bin)
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

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

pkg_origin=core
pkg_name=nettle
pkg_version=3.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'LGPL3')
pkg_description="Nettle - a low-level cryptographic library"
pkg_upstream_url=https://www.lysator.liu.se/~nisse/nettle/
pkg_source=https://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ae7a42df026550b85daca8389b6a60ba6313b0567f374392e54918588a411e94
pkg_deps=(
  core/glibc
  be/gmp
)
pkg_build_deps=(
  be/gcc
  be/make
  be/m4
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include include/nettle)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="${pkg_prefix:?}" \
    --with-gmp="$(pkg_path_for gmp)"

  make -j "$(nproc)"
}
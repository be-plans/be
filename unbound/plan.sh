pkg_origin=core
pkg_name=unbound
pkg_version=1.6.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD')
pkg_description="Unbound is a validating, recursive, and caching DNS resolver."
pkg_upstream_url=https://www.unbound.net
pkg_source=https://www.${pkg_name}.net/downloads/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=4c7e655c1d0d2d133fdeb81bc1ab3aa5c155700f66c9f5fb53fa6a5c3ea9845f
pkg_deps=(
  core/glibc lilian/libressl lilian/libsodium
  lilian/expat
)
pkg_build_deps=(
  be/gcc be/make
  be/diffutils be/coreutils
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="${pkg_prefix:?}" \
    --with-ssl="$(pkg_path_for libressl)" \
    --with-libsodium="$(pkg_path_for libsodium)" \
    --with-libexpat="$(pkg_path_for expat)"

  make -j "$(nproc)"
}

pkg_origin=core
pkg_name=p11-kit
pkg_version=0.23.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD')
pkg_description="Provides a way to load and enumerate PKCS#11 modules."
pkg_upstream_url=[empty]
pkg_source=https://p11-glue.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ba726ea8303c97467a33fca50ee79b7b35212964be808ecf9b145e9042fdfaf0
pkg_deps=(
  core/glibc
  lilian/libtasn1
  lilian/libffi
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
  lilian/file
  lilian/diffutils
  lilian/coreutils
  lilian/pkg-config
)
pkg_bin_dirs=(bin lib/p11-kit)
pkg_include_dirs=(
  include
  include/p11-kit-1
  include/p11-kit-1/p11-kit
)
pkg_lib_dirs=(lib lib/pkcs11)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  be_remove_compiler_flag "-D_GNU_SOURCE"
}

do_build() {
  sed "s|/usr/bin/file|$(pkg_path_for file)/bin/file|g" -i ./configure
  ./configure \
    --prefix="${pkg_prefix:?}" \
    --with-libtasn1="$(pkg_path_for libtasn1)" \
    --without-trust-paths

  make -j "$(nproc)"
}

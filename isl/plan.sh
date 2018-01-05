pkg_origin=core
pkg_name=isl
pkg_version=0.18
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="GNU ISL library for building GCC with Graphite loop optimizations"
pkg_upstream_url=https://gcc.gnu.org/
pkg_source=https://gcc.gnu.org/pub/gcc/infrastructure/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=6b8b0fd7f81d0a957beb3679c81bbb34ccc7568d5682844d8924424a0dadcb1b
pkg_deps=(
  core/glibc
  be/gmp
)
pkg_build_deps=(
  be/gcc
  be/make
  be/diffutils
  be/coreutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-gmp="$(pkg_path_for gmp)"

  make -j "$(nproc)"
}

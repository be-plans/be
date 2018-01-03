pkg_name=lzo
pkg_origin=core
pkg_version=2.10
pkg_license=('GPL')
pkg_source=http://www.oberhumer.com/opensource/${pkg_name}/download/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072
pkg_deps=(core/glibc)
pkg_build_deps=(
  be/coreutils be/make be/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --enable-shared \
    --disable-static
  make -j "$(nproc)"
}

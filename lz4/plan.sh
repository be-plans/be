pkg_origin=lilian
pkg_name=lz4
pkg_version=1.7.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2 Clause' 'GPL-2.0')
pkg_source=https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=0190cacd63022ccb86f44fa5041dc6c3804407ad61550ca21c382827319e7e7e
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/gcc lilian/make lilian/diffutils
  lilian/valgrind
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=http://lz4.github.io/lz4/
pkg_description="Extremely Fast Compression algorithm http://www.lz4.org"

source ../defaults.sh

do_build () {
  make PREFIX="$pkg_prefix"
}

do_check () {
  make test
}

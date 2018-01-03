pkg_name=gsl
pkg_origin=core
pkg_version=2.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPLv3')
pkg_description="GSL is a numerical library for C and C++"
pkg_upstream_url="https://www.gnu.org/software/gsl/"
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=562500b789cd599b3a4f88547a7a3280538ab2ff4939504c8b4ac4ca25feadfb
pkg_deps=(core/glibc)
pkg_build_deps=(
  be/make
  be/gcc
  be/diffutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_check() {
  make check
}

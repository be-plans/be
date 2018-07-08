pkg_origin=core
pkg_name=libiconv
pkg_version=1.15
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://ftp.gnu.org/pub/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

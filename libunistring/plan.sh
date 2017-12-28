pkg_name=libunistring
pkg_origin=be
pkg_version=0.9.7
pkg_description="Library functions for manipulating Unicode strings"
pkg_upstream_url="https://www.gnu.org/software/libunistring/"
pkg_license=('LGPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/gnu/libunistring/libunistring-${pkg_version}.tar.xz"
pkg_shasum=2e3764512aaf2ce598af5a38818c0ea23dedf1ff5460070d1b6cee5c3336e797
pkg_deps=(core/glibc)
pkg_build_deps=(
  be/gcc lilian/make lilian/diffutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_check() {
  make check
}

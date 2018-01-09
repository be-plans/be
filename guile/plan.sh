pkg_name=guile
pkg_origin=core
pkg_version=2.2.3
pkg_description="An implementation of the Scheme programming language, used in many GNU programs as an extension language."
pkg_upstream_url="https://www.gnu.org/software/guile/"
pkg_license=('LGPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/pub/gnu/guile/guile-${pkg_version}.tar.xz"
pkg_shasum=8353a8849cd7aa77be66af04bd6bf7a6207440d2f8722e46672232bb9f0a4086
pkg_deps=(
  core/glibc
  be/gcc-libs
  be/bdwgc
  be/gmp
  be/libatomic_ops
  be/libffi
  be/libtool
  be/libunistring
  be/readline
)
pkg_build_deps=(
  be/diffutils
  be/gcc
  be/make
  be/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  LDFLAGS="-lgcc_s ${LDFLAGS}"
  export LDFLAGS
}

do_check() {
  make check
}

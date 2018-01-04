pkg_name=guile
pkg_origin=core
pkg_version=2.0.14
pkg_description="An implementation of the Scheme programming language, used in many GNU programs as an extension language."
pkg_upstream_url="https://www.gnu.org/software/guile/"
pkg_license=('LGPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/pub/gnu/guile/guile-${pkg_version}.tar.xz"
pkg_shasum=e8442566256e1be14e51fc18839cd799b966bc5b16c6a1d7a7c35155a8619d82
pkg_deps=(
  be/bdwgc
  core/gcc-libs
  core/glibc
  be/gmp
  be/libatomic_ops
  lilian/libffi
  lilian/libtool
  lilian/libunistring
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

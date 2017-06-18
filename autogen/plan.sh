pkg_name=autogen
pkg_version=5.18.12
pkg_origin=lilian
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="A tool designed to simplify the creation and maintenance of programs that contain large amounts of repetitious text"
pkg_upstream_url=https://www.gnu.org/software/autogen/
pkg_source="http://ftp.gnu.org/gnu/autogen/rel${pkg_version}/autogen-${pkg_version}.tar.xz"
pkg_shasum=be3ba62e883185b6ee8475edae97d7197d701d6b9ad9c3d2df53697110c1bfd8
pkg_deps=(
  lilian/glibc lilian/gcc-libs lilian/guile
  lilian/libxml2 lilian/zlib
)
pkg_build_deps=(
  lilian/gcc lilian/make lilian/pkg-config
  lilian/diffutils lilian/which lilian/perl
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_check() {
  make check
}

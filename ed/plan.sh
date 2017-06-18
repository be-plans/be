pkg_name=ed
pkg_origin=lilian
pkg_version=1.14.2
pkg_description="The standard text editor."
pkg_upstream_url="https://www.gnu.org/software/ed/"
pkg_license=('GPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.gnu.org/gnu/ed/ed-${pkg_version}.tar.lz"
pkg_shasum=f57962ba930d70d02fc71d6be5c5f2346b16992a455ab9c43be7061dec9810db
pkg_deps=(lilian/glibc)
pkg_build_deps=(lilian/gcc lilian/make lilian/lzip lilian/diffutils)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_unpack() {
  mkdir -p "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  lzip -d --stdout "${HAB_CACHE_SRC_PATH}/${pkg_filename}" | tar x -C "${HAB_CACHE_SRC_PATH}/"
}

do_check() {
  make check
}

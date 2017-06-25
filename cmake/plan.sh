pkg_name=cmake
pkg_origin=lilian
_base_version=3.8
pkg_version=${_base_version}.2
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('BSD-3-Clause')
pkg_description="CMake is an open-source, cross-platform family of tools designed to build, test and package software"
pkg_upstream_url="https://cmake.org/"
pkg_source="https://cmake.org/files/v${_base_version}/cmake-${pkg_version}.tar.gz"
pkg_shasum=da3072794eb4c09f2d782fcee043847b99bb4cf8d4573978d9b2024214d6e92d
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/make
  lilian/gcc
  lilian/curl
  lilian/zlib
  lilian/bzip2
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./bootstrap
  ./configure --prefix="${pkg_prefix}"
  make -j "$(nproc)"
}

do_check() {
  make test
}

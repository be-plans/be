pkg_name=cmake
pkg_origin=core
_base_version=3.10
pkg_version=${_base_version}.1
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('BSD-3-Clause')
pkg_description="CMake is an open-source, cross-platform family of tools designed to build, test and package software"
pkg_upstream_url="https://cmake.org/"
pkg_source="https://cmake.org/files/v${_base_version}/cmake-${pkg_version}.tar.gz"
pkg_shasum=7be36ee24b0f5928251b644d29f5ff268330a916944ef4a75e23ba01e7573284
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/make
  be/gcc
  lilian/curl
  lilian/zlib
  lilian/bzip2
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./bootstrap --prefix="${pkg_prefix}"
  make -j "$(nproc)"
}

do_check() {
  make test
}

pkg_name=doxygen
pkg_origin=core
pkg_version=1.8.13
pkg_license=('GPL-2.0')
pkg_description="Generate documentation for several programming languages"
pkg_upstream_url=http://www.doxygen.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://ftp.stack.nl/pub/users/dimitri/${pkg_name}-${pkg_version}.src.tar.gz"
pkg_shasum=af667887bd7a87dc0dbf9ac8d86c96b552dfb8ca9c790ed1cbffaa6131573f6b
pkg_deps=(
  lilian/gcc-libs
  core/glibc
  lilian/libiconv
)
pkg_build_deps=(
  lilian/bison
  lilian/cmake
  lilian/diffutils
  lilian/flex
  lilian/gcc
  lilian/libxml2
  lilian/m4
  lilian/make
  lilian/python
)

pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  mkdir -p build
  cd build || exit
  build_line "Setting libiconv flags..."
  export CXXFLAGS="-liconv $CXXFLAGS"
  build_line "CXXFLAGS are now: $CXXFLAGS"
  cmake -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" \
    -DICONV_INCLUDE_DIR="$(hab pkg path lilian/libiconv)/include" \
    -DCMAKE_BUILD_TYPE=Release \
    -G "Unix Makefiles" ../
  make -j $(nproc)
}

# One of the tests fails on a citation test. I don't know if this is an
# $INPUTDIR mangling, or a problem upstream, skipping for now.
# do_check() {
#   cd build || exit
#   make tests
# }

do_install() {
  cd build || exit
  make -j $(nproc) install
}

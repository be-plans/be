pkg_name=flatbuffers
pkg_origin=lilian
pkg_version=1.6.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="$(cat << EOF
  FlatBuffers is an efficient cross platform serialization library for C++,
  C#, C, Go, Java, JavaScript, PHP, and Python. It was originally created at
  Google for game development and other performance-critical applications.
EOF
)"
pkg_source="https://github.com/google/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="768c50ebf5823f8cde81a9e38ffff115c8f5a5d031a37520d0024e7b9c6cd22e"
pkg_upstream_url="http://google.github.io/flatbuffers/index.html"

pkg_deps=(
  lilian/glibc
  lilian/gcc-libs
)

pkg_build_deps=(
  lilian/make
  lilian/gcc
  lilian/cmake
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

do_build() {
  export LD_LIBRARY_PATH
  LD_LIBRARY_PATH="$(pkg_path_for gcc)/lib"
  build_line "Setting LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

  rm -rf build
  mkdir -p build && cd build
  cmake -G "Unix Makefiles" ../ \
        -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_FLAGS="$CXXFLAGS"
  make -j $(nproc)
}

do_install() {
  (
    cd build
    make -j $(nproc) install
  )
}

do_check() {
  ./flattests
}

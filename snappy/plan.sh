pkg_origin=core
pkg_name=snappy
pkg_version=1.1.7
pkg_dirname=snappy-bde324c0169763688f35ee44630a26ad1f49eec3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source=https://github.com/google/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=3dfa02e873ff51a11ee02b9ca391807f0c8ea0529a4924afa645fbf97163f9d4
pkg_dirname="${pkg_name}-${pkg_version}"
pkg_deps=(core/glibc)
pkg_build_deps=(
  be/gcc
  be/ninja
  lilian/cmake
  lilian/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib lib64)
pkg_upstream_url=https://github.com/google/snappy
pkg_description="A fast compressor/decompressor http://google.github.io/snappy/"

pkg_disabled_features=(pie) # CMake takes care of this
source ../defaults.sh

do_build() {
  mkdir -p build && cd build
  cmake .. \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}"
  cmake --build . -- -j "$(nproc)" -v
}

do_install() {
  cmake --build build --target install -- -j "$(nproc)"
}

do_check () {
  cmake --build build --target check
}

pkg_origin=core
pkg_name=protobuf-c
pkg_version=1.3.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source="https://github.com/protobuf-c/protobuf-c/releases/download/v${pkg_version}/protobuf-c-${pkg_version}.tar.gz"
pkg_shasum=5dc9ad7a9b889cf7c8ff6bf72215f1874a90260f60ad4f88acf21bb15d2752a1
pkg_deps=(lilian/gcc-libs lilian/protobuf-cpp lilian/zlib)
pkg_build_deps=(lilian/gcc lilian/make lilian/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/protobuf-c/protobuf-c
pkg_description="Protocol Buffers implementation in C"

source ../defaults.sh

do_build () {
  ./configure --prefix="$pkg_prefix"
  make -j "$(nproc)"
}

do_check () {
  make check
}

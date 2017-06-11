pkg_origin=lilian
pkg_name=snappy
# CMake will soon be deprecated, let's switch currently to the master branch(snappy 1.1.4)
pkg_version=master
pkg_dirname=snappy-bde324c0169763688f35ee44630a26ad1f49eec3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source=https://github.com/google/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=f6cf80a93d8826129dd5e10fd0c7810f1063d80c4f5e6440b7be6f001b6e29e9
pkg_dirname="${pkg_name}-${pkg_version}"
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/gcc lilian/make lilian/cmake lilian/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/google/snappy
pkg_description="A fast compressor/decompressor http://google.github.io/snappy/"

source ../better_defaults.sh

do_check () {
  make check
}

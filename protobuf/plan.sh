pkg_name=protobuf
pkg_origin=lilian
pkg_version=3.3.0
pkg_license=('BSD')
pkg_source=https://github.com/google/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-cpp-${pkg_version}.tar.gz
pkg_shasum=5e2587dea2f9287885e3b04d3a94ed4e8b9b2d2c5dd1f0032ceef3ea1d153bd7
pkg_deps=(lilian/gcc lilian/zlib)
pkg_build_deps=(lilian/make)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

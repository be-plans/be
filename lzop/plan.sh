pkg_name=lzop
pkg_origin=core
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="lzop is a file compressor which is very similar to gzip. lzop uses the LZO data compression library for compression services, and its main advantages over gzip are much higher compression and decompression speed (at the cost of some compression ratio)."
pkg_upstream_url="https://www.lzop.org/"
pkg_version="1.04"
pkg_source="https://www.lzop.org/download/lzop-${pkg_version}.tar.gz"
pkg_shasum="7e72b62a8a60aff5200a047eea0773a8fb205caf7acbe1774d95147f305a2f41"
pkg_deps=(core/glibc lilian/lzo)
pkg_build_deps=(be/make be/gcc)
pkg_bin_dirs=(bin)

#TODO: Doesn't build with GCC 7.1...
# be_cxxstd="-std=gnu++11"
source ../defaults.sh

do_prepare() {
  do_default_prepare
  export CXXFLAGS="${CXXFLAGS} -std=gnu++11"
}

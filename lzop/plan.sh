pkg_name=lzop
pkg_origin=be
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="lzop is a file compressor which is very similar to gzip. lzop uses the LZO data compression library for compression services, and its main advantages over gzip are much higher compression and decompression speed (at the cost of some compression ratio)."
pkg_upstream_url=https://www.lzop.org/
pkg_version="1.03"
pkg_source="http://www.lzop.org/download/lzop-${pkg_version}.tar.gz"
pkg_shasum="c1425b8c77d49f5a679d5a126c90ea6ad99585a55e335a613cae59e909dbb2c9"
pkg_deps=(core/glibc lilian/lzo)
pkg_build_deps=(lilian/make core/gcc)
pkg_bin_dirs=(bin)

#TODO: Doesn't build with GCC 7.1...
be_generic_flags="-pipe -Wno-error"
be_cxxstd="-std=gnu++11"
source ../defaults.sh

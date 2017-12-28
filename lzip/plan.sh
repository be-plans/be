pkg_name=lzip
pkg_origin=be
pkg_version=1.19
pkg_description="A lossless data compressor with a user interface similar to the one of gzip or bzip2."
pkg_upstream_url="http://www.nongnu.org/lzip/lzip.html"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.savannah.gnu.org/releases/lzip/lzip-${pkg_version}.tar.gz"
pkg_shasum=ffadc4f56be1bc0d3ae155ec4527bd003133bdc703a753b2cc683f610e646ba9
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(be/gcc lilian/make lilian/diffutils)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_check() {
  make check
}

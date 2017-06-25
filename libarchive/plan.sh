pkg_name=libarchive
pkg_distname=$pkg_name
pkg_origin=lilian
pkg_version=3.2.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD')
pkg_source=http://www.libarchive.org/downloads/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=7bce45fd71ff01dc20d19edd78322d4965583d81b8bed8e26cacb65d6f5baa87
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(core/glibc lilian/openssl  lilian/zlib lilian/bzip2 lilian/xz)
pkg_build_deps=(lilian/gcc lilian/coreutils lilian/make)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
    ./configure \
      --prefix=$pkg_prefix \
      --without-xml2 \
      --without-lzo2
  make
}

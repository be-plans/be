pkg_name=libarchive
_distname=$pkg_name
pkg_origin=core
pkg_version=3.3.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Multi-format archive and compression library"
pkg_upstream_url="https://www.libarchive.org"
pkg_license=('BSD')
pkg_source="http://www.libarchive.org/downloads/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="ed2dbd6954792b2c054ccf8ec4b330a54b85904a80cef477a1c74643ddafa0ce"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
  be/openssl
  be/zlib
  be/bzip2
  be/xz
)
pkg_build_deps=(
  be/gcc
  be/coreutils
  be/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --without-xml2 \
    --without-lzo2
  make -j "$(nproc)"
}

do_check() {
  make check
}

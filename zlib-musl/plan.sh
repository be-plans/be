source ../zlib/plan.sh

pkg_name=zlib-musl
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Compression library implementing the deflate compression method found in gzip \
and PKZIP.\
"
pkg_upstream_url="http://www.zlib.net/"
pkg_license=('zlib')
pkg_deps=(
  be/musl
)

pkg_disabled_features=(glibc)
source ../defaults.sh

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"
}

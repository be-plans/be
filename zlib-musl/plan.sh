source ../zlib/plan.sh

pkg_name=zlib-musl
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(lilian/musl)

pkg_disabled_features=(glibc)
source ../defaults.sh

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"
}

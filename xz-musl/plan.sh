source ../xz/plan.sh

pkg_name=xz-musl
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(be/musl)

pkg_disabled_features=(glibc)
source ../defaults.sh

do_prepare() {
  do_default_prepare

  export CC=musl-gcc
  build_line "Setting CC=$CC"

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
}

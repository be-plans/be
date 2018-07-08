source ../libressl/plan.sh

pkg_name=libressl-musl
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(lilian/musl)

pkg_disabled_features=(glibc)
source ../defaults.sh

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
}

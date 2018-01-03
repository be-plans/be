source ../libarchive/plan.sh

pkg_name=libarchive-musl
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(lilian/musl be/openssl-musl lilian/zlib-musl lilian/bzip2-musl lilian/xz-musl)

source ../defaults.sh

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc be/coreutils be/sed lilian/grep be/diffutils be/make)
fi

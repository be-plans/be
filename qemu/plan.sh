pkg_name=qemu
pkg_origin=core
pkg_version=2.9.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="QEMU is a generic and open source machine emulator and virtualizer."
pkg_license=('GPL-2.0')
pkg_upstream_url="http://www.qemu.org"
pkg_source=http://download.qemu-project.org/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=f01cc33e3c5fd5fd2534ce14e369b6b111d7e54e4a4977f8c37eae668176b022
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_deps=(
  be/bzip2
  be/curl
  be/gcc-libs
  lilian/glib
  core/glibc
  lilian/jemalloc
  lilian/libaio
  be/libcap-ng
  lilian/lzo
  be/ncurses
  be/pcre
  lilian/pixman
  lilian/python2
  be/snappy
  be/util-linux
  lilian/vde2
  be/zlib
)
pkg_build_deps=(
  be/autoconf
  be/automake
  be/diffutils
  be/gcc
  be/libtool
  be/make
  be/m4
  be/pkg-config
)

source ../defaults.sh

do_build() {
  mkdir build
  pushd build

  # QEMU uses its own CFLAGS, etc. so we need to inject our environment into
  #   those variables.
  export QEMU_CFLAGS="$CFLAGS"
  ../configure \
    --prefix="${pkg_prefix}" \
    --target-list=x86_64-softmmu
  make -j "$(nproc)"
  popd
}

do_install() {
  pushd build
  make -j "$(nproc)" install
  popd
}

do_strip() {
  return 0
}

pkg_name=qemu
pkg_origin=lilian
pkg_version=2.7.0
pkg_source=http://wiki.qemu-project.org/download/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=326e739506ba690daf69fc17bd3913a6c313d9928d743bd8eddb82f403f81e53
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="QEMU is a generic and open source machine emulator and virtualizer."
pkg_upstream_url="http://www.qemu.org"
pkg_license=('GPL-2.0')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_build_deps=(
  lilian/autoconf
  lilian/automake
  lilian/diffutils
  lilian/gcc
  lilian/libtool
  lilian/make
  lilian/m4
  lilian/pkg-config
)
pkg_deps=(
  lilian/bzip2
  lilian/curl
  core/gcc-libs
  lilian/glib
  core/glibc
  core/jemalloc
  core/libaio
  lilian/libcap-ng
  core/lzo
  lilian/ncurses
  lilian/pcre
  core/pixman
  lilian/python2
  lilian/snappy
  lilian/util-linux
  core/vde2
  lilian/zlib
)

do_build() {
  mkdir build
  pushd build

  # QEMU uses its own CFLAGS, etc. so we need to inject our environment into
  #   those variables.
  export CFLAGS+=" -fPIC"
  export QEMU_CFLAGS=$CFLAGS
  ../configure --prefix="${pkg_prefix}" \
    --target-list=x86_64-softmmu
  make
  popd
}

do_install() {
  pushd build
  make install
  popd
}

do_strip() {
  return 0
}

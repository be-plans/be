pkg_name=qemu
pkg_origin=core
pkg_version=2.11.1
pkg_source=http://wiki.qemu-project.org/download/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=d9df2213ceed32e91dab7bc9dd19c1af83f91ba72c7aeef7605dfaaf81732ccb
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="QEMU is a generic and open source machine emulator and virtualizer."
pkg_upstream_url="http://www.qemu.org"
pkg_license=('GPL-2.0')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
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
pkg_deps=(
  be/bzip2
  be/curl
  be/gcc-libs
  be/glib
  core/glibc
  lilian/jemalloc
  lilian/libaio
  be/libcap-ng
  lilian/lzo
  be/ncurses
  be/patch
  be/pcre
  lilian/pixman
  be/python2
  be/snappy
  be/util-linux
  lilian/vde2
  be/zlib
)

do_prepare() {
  patch -p1 < "${PLAN_CONTEXT}/glibc-2.27.patch"
}

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

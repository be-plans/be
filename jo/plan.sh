pkg_name=jo
pkg_origin=be
pkg_version=1.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_description="jo, a small utility to create JSON objects."
pkg_upstream_url="https://github.com/jpmens/jo"
pkg_source="https://github.com/jpmens/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=63ed4766c2e0fcb5391a14033930329369f437d7060a11d82874e57e278bda5f
pkg_deps=()
pkg_build_deps=(
  lilian/linux-headers-musl lilian/musl lilian/make
  lilian/gcc lilian/diffutils
)
pkg_bin_dirs=(bin)

use_lto=true
source ../defaults.sh

do_prepare() {
  CFLAGS="-I$(pkg_path_for linux-headers-musl)/include -I$(pkg_path_for musl)/include"
  build_line "Setting CFLAGS=$CFLAGS"

  LDFLAGS="-static $LDFLAGS"
  build_line "Setting LDFLAGS=$LDFLAGS"

  export CC=musl-gcc
  build_line "Setting CC=$CC"
}

do_check() {
  make check
}

pkg_name=mc
pkg_origin=core
pkg_version=4.8.21
pkg_description="Midnight Commander."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.midnight-commander.org/mc-${pkg_version}.tar.xz
pkg_upstream_url=https://www.midnight-commander.org
pkg_shasum=8f37e546ac7c31c9c203a03b1c1d6cb2d2f623a300b86badfd367e5559fe148c
pkg_deps=(
  lilian/glib
  core/glibc
  lilian/ncurses
  lilian/pcre
)
pkg_build_deps=(
  lilian/check
  lilian/coreutils
  lilian/diffutils
  lilian/gcc
  lilian/gettext
  lilian/make
  lilian/perl
  lilian/pkg-config
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-screen=ncurses \
    --with-ncurses-libs="$(pkg_path_for ncurses)/lib" \
    --without-subshell \
    --without-x \
    --without-gpm-mouse
  make -j $(nproc)
}

pkg_name=mc
pkg_origin=be
pkg_version=4.8.19
pkg_description="Midnight Commander."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.midnight-commander.org/mc-${pkg_version}.tar.xz
pkg_upstream_url=https://www.midnight-commander.org
pkg_shasum=eb9e56bbb5b2893601d100d0e0293983049b302c5ab61bfb544ad0ee2cc1f2df
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
  be/gcc
  lilian/gettext
  lilian/make
  lilian/perl
  lilian/pkg-config
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./configure --prefix="$pkg_prefix" \
              --with-screen=ncurses \
              --with-ncurses-libs="$(pkg_path_for ncurses)/lib" \
              --without-subshell \
              --without-x \
              --without-gpm-mouse
  make -j $(nproc)
}

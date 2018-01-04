pkg_name=fish
pkg_origin=core
pkg_version=2.6.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'LGPL-2.0' 'ISC' 'BSD-2-Clause-NetBSD' 'BSD-3-Clause')
pkg_source="https://fishshell.com/files/$pkg_version/$pkg_name-$pkg_version.tar.gz"
pkg_shasum=7ee5bbd671c73e5323778982109241685d58a836e52013e18ee5d9f2e638fdfb
pkg_deps=(
  lilian/bc
  be/coreutils
  lilian/gawk
  core/gcc-libs
  core/glibc
  be/grep
  lilian/man-db
  be/ncurses
  lilian/net-tools
)
pkg_build_deps=(
  be/gcc
  be/make
)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(share/pkgconfig)
pkg_interpreters=(bin/fish)
pkg_description="fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family."
pkg_upstream_url="https://fishshell.com/"

source ../defaults.sh

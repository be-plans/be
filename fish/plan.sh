pkg_name=fish
pkg_origin=core
pkg_version=2.6.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'LGPL-2.0' 'ISC' 'BSD-2-Clause-NetBSD' 'BSD-3-Clause')
pkg_source="https://github.com/fish-shell/fish-shell/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="f8c0edadca2de379ccf305aeace660a9255fa2180c72e85e97705a24c256b2a5"
pkg_deps=(
  lilian/bc
  lilian/coreutils
  lilian/gawk
  lilian/gcc-libs
  core/glibc
  lilian/grep
  lilian/man-db
  lilian/ncurses
  lilian/net-tools
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(share/pkgconfig)
pkg_interpreters=(bin/fish)
pkg_description="fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family."
pkg_upstream_url="https://fishshell.com/"

source ../defaults.sh

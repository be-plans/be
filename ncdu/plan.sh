pkg_name=ncdu
pkg_origin=core
pkg_version=1.11
pkg_license=('MIT')
pkg_description="Ncdu is a disk usage analyzer with an ncurses interface"
pkg_upstream_url=https://dev.yorhel.nl/ncdu
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://dev.yorhel.nl/download/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=d0aea772e47463c281007f279a9041252155a2b2349b18adb9055075e141bb7b
pkg_deps=(core/glibc be/ncurses)
pkg_build_deps=(be/coreutils be/gcc be/make)
pkg_bin_dirs=(bin)

source ../defaults.sh

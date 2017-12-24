pkg_name=bison2
pkg_distname=bison
pkg_origin=be
pkg_version=2.7.1
pkg_description="A parser generator that converts an annotated context-free grammar into a parser"
pkg_upstream_url=https://www.gnu.org/software/bison/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_distname/${pkg_distname}-${pkg_version}.tar.xz
pkg_filename=${pkg_distname}-${pkg_version}.tar.xz
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_shasum=b409adcbf245baadb68d2f66accf6fdca5e282cafec1b865f4b5e963ba8ea7fb
pkg_deps=(core/glibc lilian/m4)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/perl
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_install() {
  make -j $(nproc) install
}

do_check() {
  make check
}

pkg_name=ocamlbuild
pkg_origin=be
pkg_version="0.11.0"
pkg_description="OCamlbuild is a generic build tool, that has built-in rules for building OCaml library and programs."
pkg_upstream_url="https://github.com/ocaml/ocamlbuild"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/ocamlbuild/archive/${pkg_version}.tar.gz"
pkg_shasum="1717edc841c9b98072e410f1b0bc8b84444b4b35ed3b4949ce2bec17c60103ee"
pkg_deps=(
  core/glibc
  lilian/ocaml
  lilian/coreutils
  lilian/ncurses
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  make -j "$(nproc)" \
    configure \
    OCAMLBUILD_PREFIX="${pkg_prefix}" \
    OCAMLBUILD_BINDIR="${pkg_prefix}/bin" \
    OCAMLBUILD_LIBDIR="${pkg_prefix}/lib"

  make -j "$(nproc)"
}

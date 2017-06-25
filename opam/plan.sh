pkg_name=opam
pkg_origin=lilian
pkg_description="opam is a source-based package manager. It supports multiple simultaneous compiler installations, flexible package constraints, and a Git-friendly development workflow."
pkg_upstream_url="https://opam.ocaml.org/"
pkg_version="1.2.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/opam/releases/download/${pkg_version}/opam-full-${pkg_version}.tar.gz"
pkg_shasum="15e617179251041f4bf3910257bbb8398db987d863dd3cfc288bdd958de58f00"
pkg_dirname="opam-full-${pkg_version}"
pkg_deps=(
  lilian/aspcud
  lilian/camlp4
  lilian/diffutils
  lilian/gcc
  lilian/git
  core/glibc
  lilian/m4
  lilian/make
  lilian/patch
  lilian/pkg-config
  lilian/rsync
  lilian/ocaml
  lilian/ocamlbuild
  lilian/which
)

pkg_bin_dirs=(bin)

no_pie=true
source ../defaults.sh

do_build() {
  ./configure --prefix "${pkg_prefix}"
  make lib-ext
  make
}

do_strip() {
  return 0
}

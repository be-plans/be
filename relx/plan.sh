pkg_origin=lilian
pkg_name=relx
pkg_version=3.23.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(Apache-2.0)
pkg_source=https://github.com/erlware/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=605c39be8ddf3276466770171b6835800657fd1e8e9ad28022a63f1abd09e881
pkg_deps=(lilian/erlang)
pkg_build_deps=(lilian/rebar3)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  rebar3 update
  rebar3 escriptize
}

do_install() {
  cp -R _build/default/* $pkg_prefix
  chmod +x $pkg_prefix/bin/relx
}

pkg_origin=lilian
pkg_name=rebar3
pkg_version=3.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(Apache-2.0)
pkg_source=https://github.com/erlang/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=fa8b056c37ed3781728baf0fc5b1d87a31edbc5f8dd9b50a5d1ad92b0230e5dd
pkg_deps=(lilian/erlang core/busybox-static)
pkg_build_deps=(lilian/coreutils)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  # The `/usr/bin/env` path is hardcoded, so we'll add a symlink if needed.
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv $(pkg_path_for coreutils)/bin/env /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  ./bootstrap
}

do_install() {
  cp -R _build/default/* $pkg_prefix
  fix_interpreter $pkg_prefix/bin/* core/busybox-static bin/env
  chmod +x $pkg_prefix/bin/rebar3
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}

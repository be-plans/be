pkg_name=re2c
pkg_origin=core
pkg_version=1.0.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('PDDL-1.0')
pkg_upstream_url=http://re2c.org/
pkg_description="re2c is a lexer generator for C/C++."
pkg_source=https://github.com/skvadrik/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=cf56e0de3f335f6a22d3e8c06b8b450d858a4e7875ea1b01c9233e084b90cb52
pkg_deps=(be/gcc-libs)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/gcc
  be/make
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  # The `/usr/bin/env` path is hardcoded in tests, so we'll add a symlink since fix_interpreter won't work.
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_check() {
  make check
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}

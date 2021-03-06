pkg_name=ninja
pkg_origin=core
pkg_version=1.8.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://ninja-build.org/
pkg_description="A small build system with a focus on speed"
pkg_licenses=('Apache-2.0')
_pkg_git_tree="e234a7bdb6c42f4539c0ab09b624f191287c2c10"
pkg_source=https://github.com/ninja-build/ninja/archive/${_pkg_git_tree}.tar.gz
pkg_shasum=e406cc940835c79a4ddd8a1d3e1522035c332314176a309978041fde71f79687
pkg_dirname="${pkg_name}-${_pkg_git_tree}"
pkg_deps=(
  core/glibc
  lilian/gcc-libs
)
pkg_build_deps=(
  lilian/gcc
  lilian/python
  lilian/coreutils
  lilian/re2c
)
pkg_bin_dirs=(bin)

pkg_disabled_features=(lto)
source ../defaults.sh

do_build() {
  local -r python="$(pkg_path_for python)/bin/python"
  "${python}" configure.py --bootstrap --verbose
}

do_install() {
  mkdir -p "${pkg_prefix}/bin/"
  install -s ninja "${pkg_prefix}/bin/"
  install -D -p -m 0644 misc/zsh-completion  "${pkg_svc_data_path}/zsh/site-functions/_ninja"
  install -D -p -m 0644 misc/bash-completion "${pkg_svc_config_path}/bash_completion.d/ninja"
  install -D -p -m 0644 misc/ninja.vim       "${pkg_svc_data_path}/vim/site/syntax/ninja.vim"
}

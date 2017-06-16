pkg_name=bash-completion
pkg_origin=lilian
pkg_version=2.3
pkg_license=('GPLv2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/scop/bash-completion/releases/download/${pkg_version}/bash-completion-${pkg_version}.tar.xz
pkg_shasum=b2e081af317f3da4fff3a332bfdbebeb5514ebc6c2d2a9cf781180acab15e8e9
pkg_bin_dirs=(bin)
pkg_build_deps=(lilian/make lilian/gcc lilian/autoconf lilian/automake)
pkg_deps=(core/glibc)

source ../defaults.sh

pkg_name=bash-completion
pkg_origin=core
pkg_version=2.5
pkg_license=('GPLv2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/scop/bash-completion/releases/download/${pkg_version}/bash-completion-${pkg_version}.tar.xz
pkg_shasum=b0b9540c65532825eca030f1241731383f89b2b65e80f3492c5dd2f0438c95cf
pkg_bin_dirs=(bin)
pkg_build_deps=(be/make be/gcc be/autoconf be/automake)
pkg_deps=(core/glibc)

source ../defaults.sh

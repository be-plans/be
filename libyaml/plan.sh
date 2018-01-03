pkg_name=libyaml
pkg_version=0.1.7
pkg_origin=core
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_dirname=yaml-${pkg_version}
pkg_source=http://pyyaml.org/download/${pkg_name}/yaml-${pkg_version}.tar.gz
pkg_filename=yaml-${pkg_version}.tar.gz
pkg_shasum=8088e457264a98ba451a90b8661fcb4f9d6f478f7265d48322a196cec2480729
pkg_deps=(core/glibc)
pkg_build_deps=(be/coreutils be/make be/gcc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

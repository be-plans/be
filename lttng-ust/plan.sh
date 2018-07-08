pkg_origin=core
pkg_name=lttng-ust
pkg_version=2.9.1
pkg_description="LTTng is an open source tracing framework for Linux."
pkg_upstream_url=http://lttng.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'MIT')
pkg_source=$pkg_upstream_url/files/$pkg_name/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=b891d267cdbbbd11cf34751f66c21c4a7fdc0eec3c1b53be2c40dca073b7daa4
pkg_deps=(
  lilian/coreutils
  lilian/gcc-libs
  core/glibc
  lilian/python2
  lilian/userspace-rcu
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_disabled_features=(pic)
source ../defaults.sh

do_prepare() {
  do_default_prepare
  fix_interpreter "$HAB_CACHE_SRC_PATH/$pkg_dirname/tools/lttng-gen-tp" lilian/coreutils bin/env
}

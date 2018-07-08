pkg_name=sqlite
pkg_version=3210000
pkg_origin=core
pkg_license=('Public Domain')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine."
pkg_upstream_url=https://www.sqlite.org/
pkg_source=https://www.sqlite.org/2017/${pkg_name}-autoconf-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-autoconf-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-autoconf-${pkg_version}
pkg_shasum=d7dd516775005ad87a57f428b6f86afd206cb341722927f104d3f0cf65fbbbe3
pkg_deps=(
  core/glibc
  lilian/readline
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
  lilian/coreutils
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

source ../defaults.sh

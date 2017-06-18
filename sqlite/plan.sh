pkg_name=sqlite
pkg_version=3190300
pkg_origin=lilian
pkg_license=('Public Domain')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine."
pkg_upstream_url=https://www.sqlite.org/
pkg_source=https://www.sqlite.org/2017/${pkg_name}-autoconf-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-autoconf-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-autoconf-${pkg_version}
pkg_shasum=06129c03dced9f87733a8cba408871bd60673b8f93b920ba8d815efab0a06301
pkg_deps=(lilian/glibc lilian/readline)
pkg_build_deps=(lilian/gcc lilian/make lilian/coreutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

source ../defaults.sh

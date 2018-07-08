pkg_origin=core
pkg_name=memcached
pkg_version=1.5.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Distributed memory object caching system"
pkg_upstream_url="https://memcached.org/"
pkg_license=('BSD')
pkg_source=http://www.memcached.org/files/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=e0c3cfa89fa4c2ffd8aa45df7825c6d1a2423ac89ab1a7c4f42bb9803f7403d4
pkg_deps=(core/glibc lilian/libevent)
pkg_build_deps=(lilian/git lilian/gcc lilian/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_svc_run="memcached"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

source ../defaults.sh

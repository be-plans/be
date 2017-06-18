pkg_origin=lilian
pkg_name=userspace-rcu
pkg_version=0.10.0
pkg_description="liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library.
  This data synchronization library provides read-side access which scales
  linearly with the number of cores."
pkg_upstream_url=http://liburcu.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source=http://www.lttng.org/files/urcu/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=7cb58a7ba5151198087f025dc8d19d8918e9c6d56772f039696c111d9aad3190
pkg_deps=(
  lilian/gcc-libs
  lilian/glibc
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

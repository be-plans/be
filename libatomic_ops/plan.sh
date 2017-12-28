pkg_name=libatomic_ops
pkg_origin=be
pkg_version=7.6.0
pkg_description="Atomic memory update operations"
pkg_upstream_url="https://github.com/ivmai/libatomic_ops"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.ivmaisoft.com/_bin/atomic_ops/libatomic_ops-${pkg_version}.tar.gz"
pkg_shasum=8e2c06d1d7a05339aae2ddceff7ac54552854c1cbf2bb34c06eca7974476d40f
pkg_deps=(core/glibc)
pkg_build_deps=(be/gcc lilian/make lilian/diffutils)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_check() {
  make check
}

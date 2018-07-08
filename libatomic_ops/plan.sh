pkg_name=libatomic_ops
pkg_origin=core
pkg_version=7.6.2
pkg_description="Atomic memory update operations"
pkg_upstream_url="https://github.com/ivmai/libatomic_ops"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.ivmaisoft.com/_bin/atomic_ops/libatomic_ops-${pkg_version}.tar.gz"
pkg_shasum=219724edad3d580d4d37b22e1d7cb52f0006d282d26a9b8681b560a625142ee6
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
  lilian/diffutils
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_check() {
  make check
}

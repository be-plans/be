pkg_name=libdrm
pkg_origin=core
pkg_version=2.4.88
pkg_description="Direct Rendering Manager"
pkg_upstream_url="https://dri.freedesktop.org/wiki/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://dri.freedesktop.org/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=a8b458db6a73c717baee2e249d39511fb6f5c0f5f24dee2770935eddeda1a017
pkg_deps=(
  lilian/libpciaccess
  core/glibc
)
# Configure script will not find CAIRO. This is a choice we made, see:
# https://github.com/be-plans/lilian/pull/994#discussion_r154243539
pkg_build_deps=(
  lilian/diffutils
  lilian/gcc
  lilian/libxslt
  lilian/make
  lilian/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  make check
}

pkg_origin=be
pkg_name=ccache
pkg_version=3.3.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="ccache is a compiler cache. It speeds up recompilation by caching previous compilations and "\
"detecting when the same compilation is being done again."
pkg_upstream_url=https://ccache.samba.org/
pkg_source="https://www.samba.org/ftp/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=24f15bf389e38c41548c9c259532187774ec0cb9686c3497bbb75504c8dc404f
pkg_deps=(core/glibc lilian/zlib)
pkg_build_deps=(lilian/gcc lilian/make lilian/diffutils lilian/which)
pkg_bin_dirs=(bin)

use_lto=true
source ../defaults.sh

do_check() {
  make test
}

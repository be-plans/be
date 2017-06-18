pkg_origin=lilian
pkg_name=libev
pkg_version=4.24
pkg_description="A full-featured and high-performance (see benchmark) event loop that is loosely modelled after libevent."
pkg_upstream_url=http://software.schmorp.de/pkg/libev.html
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh"
pkg_license=('BSD-2-Clause')
pkg_source=http://dist.schmorp.de/libev/Attic/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=973593d3479abdf657674a55afe5f78624b0e440614e2b8cb3a07f16d4d7f821
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/cacerts lilian/gcc lilian/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

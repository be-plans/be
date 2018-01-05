pkg_name=nghttp2
pkg_origin=core
pkg_version=1.29.0
pkg_description="nghttp2 is an open source HTTP/2 C Library."
pkg_upstream_url=https://nghttp2.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source=https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=a7a1b18be57be6a53a7739988ea27d6ec9209e7b0e8372b8483cd911d7838739
pkg_dirname=${pkg_name}-${pkg_version}
pkg_build_deps=(
  be/make
  be/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

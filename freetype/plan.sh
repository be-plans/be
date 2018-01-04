pkg_name=freetype
pkg_version=2.8
pkg_origin=core
pkg_description="A software library to render fonts"
pkg_upstream_url="https://www.freetype.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('FreeType' 'GPL-2.0')
pkg_source=http://download.savannah.gnu.org/releases/freetype/${pkg_name}-${pkg_version}.tar.bz2
pkg_filename=${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=a3c603ed84c3c2495f9c9331fe6bba3bb0ee65e06ec331e0a0fb52158291b40b
pkg_deps=(
  core/glibc lilian/libpng
  be/zlib be/bzip2
)
pkg_build_deps=(
  be/gcc be/make be/coreutils
  be/pkg-config be/diffutils
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

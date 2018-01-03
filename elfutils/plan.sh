pkg_name=elfutils
pkg_origin=core
pkg_version=0.169
pkg_license=('GPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="elfutils is a collection of various binary tools such as
  eu-objdump, eu-readelf, and other utilities that allow you to inspect and
  manipulate ELF files."
pkg_upstream_url=https://fedorahosted.org/elfutils/
pkg_source=https://fedorahosted.org/releases/e/l/$pkg_name/$pkg_version/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=9412fac7b30872b738bc1ed1ebcaed54493c26ef9a67887913498c17b10f3bc2
pkg_deps=(
  core/glibc
  lilian/zlib
)
pkg_build_deps=(
  be/gcc
  core/glibc
  lilian/m4
  be/make
  lilian/zlib
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

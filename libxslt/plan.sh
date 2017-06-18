pkg_name=libxslt
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.1.29
pkg_origin=lilian
pkg_license=('libxslt')
pkg_source=ftp://xmlsoft.org/libxslt/libxslt-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=b5976e3857837e7617b29f2249ebb5eeac34e249208d31f1fbf7a6ba7a4090ce
pkg_deps=(lilian/glibc lilian/libxml2 lilian/zlib)
pkg_build_deps=(lilian/coreutils lilian/patch lilian/make lilian/gcc)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

pkg_name=libxslt
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Libxslt is the XSLT C library developed for the GNOME project"
pkg_upstream_url=http://xmlsoft.org/XSLT/
pkg_version=1.1.31
pkg_origin=lilian
pkg_license=('libxslt')
pkg_source=http://xmlsoft.org/sources/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=db25e96b6b801144277e67c05b10560ac09dfff82ccd53a154ce86e43622f3ab
pkg_deps=(core/glibc lilian/libxml2 lilian/zlib)
pkg_build_deps=(lilian/coreutils lilian/patch lilian/make lilian/gcc)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

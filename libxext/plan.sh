pkg_name=libxext
pkg_distname=libXext
pkg_origin=core
pkg_version=1.3.3
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 miscellaneous extensions library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="b518d4d332231f313371fdefac59e3776f4f0823bcb23cf7c7305bfb57b16e35"
pkg_deps=(core/glibc lilian/xlib lilian/libxcb lilian/libxau lilian/libxdmcp)
pkg_build_deps=(lilian/gcc lilian/make lilian/pkg-config lilian/xproto lilian/xextproto lilian/kbproto lilian/libpthread-stubs)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_check() {
    make check
}

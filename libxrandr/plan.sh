pkg_name=libxrandr
pkg_distname=libXrandr
pkg_origin=core
pkg_version=1.5.1
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X Resize and Rotate library"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="1ff9e7fa0e4adea912b16a5f0cfa7c1d35b0dcda0e216831f7715c8a3abcf51a"
pkg_deps=(core/glibc lilian/libxrender lilian/xlib lilian/libxcb lilian/libxau lilian/libxdmcp lilian/libxext)
pkg_build_deps=(lilian/diffutils lilian/gcc lilian/make lilian/pkg-config lilian/util-macros lilian/renderproto lilian/xproto lilian/kbproto lilian/libpthread-stubs lilian/xextproto lilian/randrproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}

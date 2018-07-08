pkg_name=libxi
pkg_distname=libXi
pkg_origin=core
pkg_version=1.7.9
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X.Org Libraries: libXi"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum="c2e6b8ff84f9448386c1b5510a5cf5a16d788f76db018194dacdc200180faf45"
pkg_deps=(core/glibc lilian/xlib lilian/libxext lilian/libxcb lilian/libxau lilian/libxdmcp)
pkg_build_deps=(lilian/gcc lilian/make lilian/pkg-config lilian/xproto lilian/xextproto lilian/kbproto lilian/inputproto lilian/libpthread-stubs lilian/libxfixes lilian/fixesproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}

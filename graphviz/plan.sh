pkg_origin=lilian
pkg_name=graphviz
pkg_description="Graphviz - Graph Visualization Software"
pkg_upstream_url=http://www.graphviz.org/
pkg_version=2.40.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("EPL-1.0")
pkg_source=http://www.graphviz.org/pub/graphviz/stable/SOURCES/graphviz-${pkg_version}.tar.gz
pkg_shasum=ca5218fade0204d59947126c38439f432853543b0818d9d728c589dfe7f3a421
pkg_dirname=${pkg_name}-${pkg_version}
pkg_deps=(lilian/glibc)
pkg_build_deps=(
    lilian/autoconf
    lilian/coreutils
    lilian/gcc
    lilian/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

do_prepare() {
    do_default_prepare
    autoconf
}

do_install() {
    do_default_install
    install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}

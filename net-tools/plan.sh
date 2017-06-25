pkg_name=net-tools
pkg_distname=$pkg_name
pkg_origin=lilian
pkg_version=1.60
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source=http://downloads.sourceforge.net/net-tools/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=7ae4dd6d44d6715f18e10559ffd270511b6e55a8900ca54fbebafe0ae6cf7d7b
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(core/glibc lilian/coreutils)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin sbin)

source ../defaults.sh

do_build() {
    patch -p1 -i "${PLAN_CONTEXT}/fix_default.patch"
    cp "${PLAN_CONTEXT}/config.h" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/config.h"
    make
}

do_install() {
    make install BASEDIR="${pkg_prefix}"
}

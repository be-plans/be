pkg_name=procps-ng
pkg_origin=core
pkg_version=3.3.12
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gpl' 'lgpl')
pkg_source=https://downloads.sourceforge.net/project/${pkg_name}/Production/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=6ed65ab86318f37904e8f9014415a098bec5bc53653e5d9ab404f95ca5e1a7d4
pkg_deps=(core/glibc lilian/ncurses)
pkg_build_deps=(be/coreutils be/diffutils be/patch be/make be/gcc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  # The Util-linux package will provide the `kill` command
  ./configure \
    --prefix=$pkg_prefix \
    --sbindir=$pkg_prefix/bin \
    --disable-kill
  make -j $(nproc)
}

do_check() {
  make check
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc)
fi

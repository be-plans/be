pkg_name=xz
pkg_distname=$pkg_name
pkg_origin=be
pkg_version=5.2.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gpl2+' 'lgpl2+')
pkg_source=http://tukaani.org/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.xz
pkg_shasum=7876096b053ad598c31f6df35f7de5cd9ff2ba3162e5a5554e4fc198447e0347
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make      be/gcc       lilian/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

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
  pkg_build_deps=(be/gcc lilian/coreutils lilian/sed lilian/diffutils)
fi

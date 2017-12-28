pkg_name=gettext
pkg_origin=be
pkg_version=0.19.8.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'lgpl2+')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=105556dbc5c3fbbc2aa0edb46d22d055748b6f5c7cd7a8d99f8e7eb84e938be4
pkg_deps=(core/glibc core/gcc-libs lilian/acl lilian/xz)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make be/gcc lilian/sed lilian/findutils
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh

do_build() {
  ./configure --prefix="$pkg_prefix"
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
  pkg_build_deps=(be/gcc lilian/coreutils lilian/sed lilian/diffutils lilian/findutils)
fi

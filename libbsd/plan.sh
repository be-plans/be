pkg_name=libbsd
pkg_origin=be
pkg_version=0.8.3
pkg_license=('custom')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://libbsd.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=934b634f4dfd865b6482650b8f522c70ae65c463529de8be907b53c89c3a34a8
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make be/gcc lilian/sed
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_install() {
  do_default_install

  # Install license file from README
  install -Dm644 COPYING "$pkg_prefix/share/licenses/LICENSE"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc lilian/coreutils lilian/sed lilian/diffutils lilian/make lilian/patch)
fi

pkg_name=libcap
pkg_origin=be
pkg_version=2.25
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2')
pkg_source=https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=693c8ac51e983ee678205571ef272439d83afe62dd8e424ea14ad9790bc35162
pkg_deps=(core/glibc lilian/attr)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make be/gcc core/linux-headers
  lilian/perl
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

no_pie=true
source ../defaults.sh

do_prepare() {
  do_default_prepare

  # Install binaries under `bin/` vs. `sbin/`
  sed -i "/SBINDIR/s#sbin#bin#" Make.Rules
}

do_build() {
  make -j $(nproc) KERNEL_HEADERS="$(pkg_path_for linux-headers)/include" LDFLAGS="$LDFLAGS"
}

do_install() {
  make -j $(nproc) prefix="$pkg_prefix" lib=lib RAISE_SETFCAP=no install
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc core/linux-headers)
fi

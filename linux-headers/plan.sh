pkg_origin=lilian
pkg_name=linux-headers
pkg_version=4.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source=https://www.kernel.org/pub/linux/kernel/v4.x/linux-${pkg_version}.tar.xz
pkg_shasum=401d7c8fef594999a460d10c72c5a94e9c2e1022f16795ec51746b0d165418b2
pkg_dirname=linux-$pkg_version
pkg_deps=()
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc
)
pkg_include_dirs=(include)

do_build() {
  make headers_install ARCH=x86 INSTALL_HDR_PATH="$pkg_prefix"
}

do_install() {
  find "$pkg_prefix/include" \( -name ..install.cmd -o -name .install \) -print0 | xargs -0 rm -v
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=()
fi

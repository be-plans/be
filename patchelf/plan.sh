pkg_name=patchelf
pkg_description="A small utility to modify the dynamic linker and RPATH of ELF executables"
pkg_origin=core
pkg_version=0.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_upstream_url="https://nixos.org/patchelf.html"
pkg_source=https://github.com/NixOS/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=cf0693e794229e19edcf2299427b5a352e0f4d4f06f9d3856e30ddb0344d5ce8
pkg_build_deps=(
  be/autoconf
  be/automake
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./bootstrap.sh
  ./configure --prefix="${pkg_prefix}"
  make -j "$(nproc)"
}

if [[ -n "$FIRST_PASS" ]]; then
  # Waiting on gcc-libs to link libgcc and libstdc++, but because we need
  # this package to prepare gcc-libs, we'll do the cheap version first
  # that relies on the full gcc version of these shared libraries
  pkg_deps=(core/glibc be/gcc)
else
  pkg_deps=(core/glibc core/gcc-libs)
fi

do_begin() {
  if [[ -n "$FIRST_PASS" ]]; then
    build_line "Using libgcc and libstdc++ from be/gcc"
  fi
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

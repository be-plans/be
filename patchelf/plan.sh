pkg_name=patchelf
pkg_description="A small utility to modify the dynamic linker and RPATH of ELF executables"
pkg_origin=lilian
pkg_version=0.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_upstream_url="https://nixos.org/patchelf.html"
pkg_source=http://releases.nixos.org/$pkg_name/${pkg_name}-$pkg_version/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=f2aa40a6148cb3b0ca807a1bf836b081793e55ec9e5540a5356d800132be7e0a
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc
)
pkg_bin_dirs=(bin)

source ../defaults.sh

if [[ -n "$FIRST_PASS" ]]; then
  # Waiting on gcc-libs to link libgcc and libstdc++, but because we need
  # this package to prepare gcc-libs, we'll do the cheap version first
  # that relies on the full gcc version of these shared libraries
  pkg_deps=(lilian/glibc lilian/gcc)
else
  pkg_deps=(lilian/glibc lilian/gcc-libs)
fi

do_begin() {
  if [[ -n "$FIRST_PASS" ]]; then
    build_line "Using libgcc and libstdc++ from lilian/gcc"
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
  pkg_build_deps=(lilian/gcc)
fi

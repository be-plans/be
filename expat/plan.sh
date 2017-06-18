pkg_name=expat
pkg_origin=lilian
pkg_version=2.2.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('mit')
pkg_source=http://downloads.sourceforge.net/sourceforge/expat/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=d9e50ff2d19b3538bd2127902a89987474e1a4db8e43a66a4d1a712ab9a504ff
pkg_deps=(lilian/glibc lilian/gcc-libs)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  # Patch for CVE-2015-1283
  #
  # Thanks to: https://github.com/NixOS/nixpkgs/blob/release-15.09/pkgs/development/libraries/expat/default.nix
  # patch -p1 -i $PLAN_CONTEXT/CVE-2015-1283.patch
}

do_default_build() {
  ./configure --prefix="${pkg_prefix:?}"
  make -j $(nproc)
}

do_check() {
  # Set `LDFLAGS` for the c++ test code to find libstdc++
  make check LDFLAGS="$LDFLAGS -lstdc++"
}

do_install() {
  do_default_install

  # Install license file
  install -Dm644 COPYING "$pkgdir/share/licenses/COPYING"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/coreutils)
fi

pkg_name=diffutils
pkg_origin=lilian
pkg_version=3.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=dad398ccd5b9faca6b0ab219a036453f62a602a56203ac659b43e889bec35533
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/coreutils core/patch core/make core/gcc core/sed)
pkg_bin_dirs=(bin)

do_check() {
  # Fixes a broken test with either gcc 5.2.x and/or perl 5.22.x:
  # FAIL: test-update-copyright.sh
  #
  # Thanks to: http://permalink.gmane.org/gmane.linux.lfs.devel/16285
  sed -i 's/copyright{/copyright\\{/' build-aux/update-copyright

  # Add ./src to PATH so that the test suite can use the just-build `cmp`
  # program. Seems pretty meta to me...
  make check PATH="$(pwd)/src:$PATH"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(core/gcc core/coreutils core/sed)
fi

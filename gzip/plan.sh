pkg_name=gzip
pkg_origin=core
pkg_version=1.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=ae506144fc198bd8f81f1f4ad19ce63d5a2d65e42333255977cf1dcf1479089a
pkg_deps=(
  core/glibc
  be/less
  be/grep
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
  be/sed
  be/xz
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  build_line "Patching 'zless' with the full path to 'less'"
  sed -i \
    -e "s,less -V,$(pkg_path_for less)/bin/less -V,g" \
    -e "s,exec less,exec $(pkg_path_for less)/bin/less,g" \
    zless.in
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix"
  # Prevent a hard dependency on the grep package
  make \
    -j"$(nproc)" \
    GREP="$(pkg_path_for grep)/bin/grep" \
    LESS="$(pkg_path_for less)/bin/less"
}

do_check() {
  # Skip help-version test for running zmore which requires `more` on PATH. We
  # don't yet have one built and will assume that it works well enough.
  sed -i -e "s,zmore,,g" tests/Makefile

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
  pkg_build_deps=(be/gcc be/coreutils be/sed be/diffutils be/xz)
fi

pkg_name=libbsd
pkg_origin=core
pkg_version=0.8.7
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
This library provides useful functions commonly found on BSD systems, and \
lacking on others like GNU systems\
"
pkg_upstream_url="https://libbsd.freedesktop.org/wiki/"
pkg_license=('custom')
pkg_source="https://libbsd.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="f548f10e5af5a08b1e22889ce84315b1ebe41505b015c9596bad03fd13a12b31"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/file
  lilian/gcc
  lilian/make
  lilian/patch
  lilian/pkg-config
  lilian/sed
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for "lilian/file")/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_install() {
  do_default_install

  # Install license file from README
  install -Dm644 COPYING "${pkg_prefix}/share/licenses/LICENSE"
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
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
  pkg_build_deps=(
    lilian/gcc/7.1.0/20170624225400
    lilian/coreutils/8.27/20170624233515
    lilian/sed/4.4/20170624233625
    lilian/diffutils/3.6/20170624234540
    lilian/make/4.2.1/20170624234911
    lilian/patch/2.7.5/20170624234926
    lilian/file/5.31/20170625112308
  )
fi

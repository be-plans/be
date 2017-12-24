pkg_name=check
pkg_origin=be
pkg_version=0.10.0
pkg_license=('LGPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://downloads.sourceforge.net/sourceforge/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=f5f50766aa6f8fe5a2df752666ca01a950add45079aa06416b83765b1cf71052
pkg_deps=(core/glibc lilian/gawk)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_install() {
  do_default_install

  # Clean up extra files
  rm -rfv $pkg_prefix/share/info/dir $pkg_prefix/share/doc/check/*ChangeLog*
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/coreutils lilian/sed lilian/diffutils lilian/make lilian/patch)
fi

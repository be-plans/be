0pkg_name=bison
pkg_origin=core
pkg_version=3.0.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Bison is a general-purpose parser generator that converts an annotated \
context-free grammar into a deterministic LR or generalized LR (GLR) parser \
employing LALR(1) parser tables.\
"
pkg_upstream_url="https://www.gnu.org/software/bison/"
pkg_license=('GPL-3.0')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="a72428c7917bdf9fa93cb8181c971b6e22834125848cf1d03ce10b1bb0716fe1"
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/m4
  lilian/perl
)

pkg_bin_dirs=(bin)

pkg_disabled_features=(lto pic)
source ../defaults.sh

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
	  lilian/m4/1.4.18/20170624225210
	  lilian/coreutils/8.27/20170624233515
  )
fi

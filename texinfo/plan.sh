pkg_name=texinfo
pkg_origin=core
pkg_version=6.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Texinfo is the official documentation format of the GNU project. It was \
invented by Richard Stallman and Bob Chassell many years ago, loosely based on \
Brian Reid's Scribe and other formatting languages of the time. It is used by \
many non-GNU projects as well.\
"
pkg_upstream_url="http://www.gnu.org/software/texinfo/"
pkg_license=('gplv3+')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="77774b3f4a06c20705cc2ef1c804864422e3cf95235e965b1f00a46df7da5f62"
pkg_deps=(
  core/glibc
  be/ncurses
  be/perl
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
  be/sed
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_check() {
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
  pkg_build_deps=(
    lilian/gcc/7.1.0/20170624225400
    lilian/coreutils/8.27/20170624233515
    lilian/sed/4.4/20170624233625
    lilian/diffutils/3.6/20170624234540
    lilian/make/4.2.1/20170624234911
    lilian/patch/2.7.5/20170624234926
  )
fi

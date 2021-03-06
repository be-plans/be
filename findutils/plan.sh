pkg_name=findutils
pkg_origin=core
pkg_version=4.6.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Find Utilities are the basic directory searching utilities of the GNU \
operating system. These programs are typically used in conjunction with other \
programs to provide modular and powerful directory search and file locating \
capabilities to other commands.\
"
pkg_upstream_url="http://www.gnu.org/software/findutils"
pkg_license=('gplv3+')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="ded4c9f73731cd48fec3b6bdaccce896473b6d8e337e9612e16cf1431bb1169d"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/sed
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --localstatedir="$pkg_svc_var_path/locate"
  make -j $(nproc)
}

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
  )
fi

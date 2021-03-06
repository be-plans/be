pkg_name=gettext
pkg_origin=core
pkg_version=0.19.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GNU internationalization library."
pkg_upstream_url="http://www.gnu.org/software/gettext/"
pkg_license=('gplv2+' 'lgpl2+')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="3da4f6bd79685648ecf46dab51d66fcdddc156f41ed07e580a696a38ac61d48f"
pkg_deps=(
  core/glibc
  lilian/gcc-libs
  lilian/acl
  lilian/xz
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/sed
  lilian/findutils
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh
do_prepare() {
  do_default_prepare

  patch -p1 -i "$PLAN_CONTEXT/disable-test.patch"
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix"
  make -j"$(nproc)"
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
    lilian/findutils/4.4.2/20170624234608
  )
fi

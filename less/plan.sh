pkg_name=less
pkg_origin=core
pkg_version=530
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
A terminal pager program used to view (but not change) the contents of a text \
file.\
"
pkg_upstream_url="http://www.greenwoodsoftware.com/less/index.html"
pkg_license=('gplv3+')
pkg_source="http://www.greenwoodsoftware.com/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="503f91ab0af4846f34f0444ab71c4b286123f0044a4964f1ae781486c617f2e2"
pkg_deps=(
  core/glibc
  be/ncurses
  be/pcre
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
)
pkg_bin_dirs=(bin)

#TODO: Check for newer version
pkg_disabled_features=(pic)
source ../defaults.sh

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --sysconfdir=/etc \
    --with-regex=pcre

  make -j "$(nproc)"
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
    be/gcc
    be/coreutils
  )
fi

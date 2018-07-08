pkg_name=mg
pkg_origin=core
pkg_version=20171014
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
mg is Micro GNU/emacs, this is a portable version of the mg maintained by the \
OpenBSD team.\
"
pkg_upstream_url="https://homepage.boetes.org/software/mg/"
pkg_license=('publicdomain')
pkg_source="http://homepage.boetes.org/software/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="51519698f3f44acd984d7805e4e315ded50c15aba8222521f88756fd67745341"
pkg_deps=(
  core/glibc
  lilian/ncurses
  lilian/libbsd
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/sed
  lilian/pkg-config
  lilian/clens
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  be_remove_linker_flag "-Wl,--as-needed"
  # shellcheck disable=SC2002
  cat "$PLAN_CONTEXT/cleanup.patch" \
    | sed \
      -e "s,@prefix@,$pkg_prefix,g" \
      -e "s,@clens_prefix@,$(pkg_path_for clens),g" \
      -e "s,@libbsd_prefix@,$(pkg_path_for libbsd),g" \
    | patch -p1

    # For "20170401":
    # -e "s,@ncurses_prefix@,$(pkg_path_for ncurses),g" \

    # Add: "--silence-errors" to PKG_CONFIG
    # Also, "-I@ncurses_prefix@/incldue" to CFLAGS
}

do_build() {
  make -j "$(nproc)" \
    prefix="$pkg_prefix" \
    PKG_CONFIG=pkg-config \
    INSTALL=install \
    STRIP=strip
}

do_install() {
  do_default_install

  # Install license file from README
  install -Dm644 README "$pkg_prefix/share/licenses/README"
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
    lilian/pkg-config/0.29.2/20170624235734
    lilian/coreutils/8.27/20170624233515
    lilian/sed/4.4/20170624233625
    lilian/diffutils/3.6/20170624234540
    lilian/make/4.2.1/20170624234911
    lilian/patch/2.7.5/20170624234926
    lilian/clens/0.7.0/20170626203513
  )
fi

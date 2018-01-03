pkg_name=mg
pkg_origin=core
pkg_version=20160118
pkg_description="mg is Micro GNU/emacs, this is a portable version of the mg maintained by the OpenBSD team"
pkg_license=('publicdomain')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://homepage.boetes.org/software/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=26450b2564bec0b0afc465fd24a1917dc31508c5500c3a36823b9c763a2b8636
pkg_deps=(core/glibc lilian/ncurses lilian/libbsd)
pkg_build_deps=(
  be/coreutils be/diffutils be/patch
  be/make be/gcc be/sed
  lilian/pkg-config lilian/clens
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  cat $PLAN_CONTEXT/cleanup.patch \
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
    prefix=$pkg_prefix \
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
  pkg_build_deps=(be/gcc lilian/pkg-config be/coreutils be/sed be/diffutils be/make be/patch lilian/clens)
fi

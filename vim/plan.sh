pkg_name=vim
pkg_origin=lilian
pkg_version=8.0.0633
pkg_license=('vim')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Vim is a greatly improved version of the good old UNIX editor Vi"
pkg_source="http://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=6b95763a977e9cd33b5fe64275bf3b04b44724d8746c29296c9cdfca4f045fa0
pkg_deps=(core/glibc lilian/acl lilian/ncurses)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/sed lilian/autoconf
)
pkg_bin_dirs=(bin)

source ../better_defaults.sh

do_prepare() {
  do_default_prepare

  pushd src > /dev/null
    autoconf
  popd > /dev/null

  export CPPFLAGS="$CPPFLAGS $CFLAGS"
  build_line "Setting CPPFLAGS=$CPPFLAGS"
}

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-compiledby="Habitat, vim release ${pkg_version}" \
    --with-features=huge \
    --enable-acl \
    --with-x=no \
    --disable-gui \
    --enable-multibyte
  make -j $(nproc)
}

do_install() {
  do_default_install

  # Add a `vi` which symlinks to `vim`
  ln -sv vim "${pkg_prefix}/bin/vi"

  # Install license file
  install -Dm644 runtime/doc/uganda.txt "${pkg_prefix}/share/licenses/license.txt"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/coreutils lilian/sed lilian/diffutils lilian/make lilian/patch lilian/autoconf)
fi

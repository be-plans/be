pkg_origin=core
pkg_name=libmpc
pkg_distname=mpc
pkg_version=1.1.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
### Switch back the source after the official 1.1.0 release(mpfr 4.0 compat)
pkg_source="https://scm.gforge.inria.fr/anonscm/gitweb?p=mpc/mpc.git;a=snapshot;h=608a22178bea8fe9bebab88b5bc23a914f0926da;sf=tgz"
pkg_shasum=6397d8cd3d52ec2a4dde49a8f64cd1d8f0267e1a0fc695e2bdfee4c05b5dd55c
pkg_dirname=${pkg_name}-${pkg_version}
### end
# pkg_source=http://www.multiprecision.org/mpc/download/${pkg_distname}-${pkg_version}.tar.gz
# pkg_shasum=617decc6ea09889fb08ede330917a00b16809b8db88c29c31bfbb49cbf88ecc3
pkg_deps=(
  core/glibc
  be/gmp
  be/mpfr
)
pkg_build_deps=(
  ### Remove autoconf stuff after official 1.1.0 release
  be/autoconf
  be/automake
  be/pkg-config
  be/libtool
  be/texinfo
  be/m4
  be/git
  ### end
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
  be/binutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=${pkg_distname}-${pkg_version}

pkg_disabled_features=(pic)
source ../defaults.sh

do_unpack() {
  mkdir -p "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname" > /dev/null
    tar xf "$HAB_CACHE_SRC_PATH/$pkg_filename" --strip 1 --no-same-owner
  popd > /dev/null
}

do_prepare() {
  do_default_prepare

  export LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  build_line "Updating LDFLAGS=$LDFLAGS"
}

do_build() {
  autoreconf --install --force --verbose
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-gmp="$(pkg_path_for gmp)" \
    --with-mpfr="$(pkg_path_for mpfr)"

  make -j "$(nproc)"
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
  pkg_build_deps=(be/binutils)
fi

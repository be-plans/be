pkg_name=gnupg
pkg_distname=$pkg_name
pkg_origin=be
pkg_version=1.4.21
pkg_license=('gplv3+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.bz2
pkg_shasum=6b47a3100c857dcab3c60e6152e56a997f2c7862c1b8b2b25adf3884a1ae2276
pkg_deps=(
  core/glibc lilian/zlib lilian/bzip2
  lilian/readline
)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make be/gcc lilian/sed lilian/findutils
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix=${pkg_prefix} \
    --sbindir=$pkg_prefix/bin

  make -j $(nproc)
}

do_check() {
  find tests -type f \
    | xargs sed -e "s,/bin/pwd,$(pkg_path_for coreutils)/bin/pwd,g" -i

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
  pkg_build_deps=(be/gcc lilian/coreutils lilian/sed lilian/diffutils lilian/findutils lilian/make lilian/patch)
fi

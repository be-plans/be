pkg_name=gnupg
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=1.4.22
pkg_license=('gplv3+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.bz2
pkg_shasum=9594a24bec63a21568424242e3f198b9d9828dea5ff0c335e47b06f835f930b4
pkg_deps=(
  core/glibc
  be/zlib
  be/bzip2
  be/readline
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
  be/sed
  lilian/findutils
)
pkg_bin_dirs=(bin)

pkg_disabled_features=(lto pic)
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
  pkg_build_deps=(be/gcc be/coreutils be/sed be/diffutils lilian/findutils be/make be/patch)
fi

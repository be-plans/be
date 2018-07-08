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
  lilian/zlib
  lilian/bzip2
  lilian/readline
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
  pkg_build_deps=(
    lilian/gcc/7.1.0/20170624225400
    lilian/coreutils/8.27/20170624233515
    lilian/sed/4.4/20170624233625
    lilian/diffutils/3.6/20170624234540
    lilian/findutils/4.4.2/20170624234608
    lilian/make/4.2.1/20170624234911
    lilian/patch/2.7.5/20170624234926
  )
fi

pkg_name=unzip
pkg_origin=core
pkg_version=6.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
UnZip is an extraction utility for archives compressed in .zip format (also \
called 'zipfiles').\
"
pkg_upstream_url="https://sourceforge.net/projects/infozip/"
pkg_license=('Zlib')
pkg_source="https://downloads.sourceforge.net/infozip/unzip60.tar.gz"
pkg_shasum="036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37"
pkg_dirname=unzip60
pkg_deps=(
  be/bzip2
  core/glibc
)
pkg_build_deps=(
  be/gcc
  be/make
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  DEFINES="-DACORN_FTYPE_NFS -DWILD_STOP_AT_DIR -DLARGE_FILE_SUPPORT \
    -DUNICODE_SUPPORT -DUNICODE_WCHAR -DUTF8_MAYBE_NATIVE -DNO_LCHMOD \
    -DDATE_FORMAT=DF_YMD -DUSE_BZIP2 -DNOMEMCPY -DNO_WORKING_ISPRINT"
  make -j "$(nproc)" \
    -f unix/Makefile \
    prefix="${pkg_prefix}" \
    D_USE_BZ2=-DUSE_BZIP2 \
    L_BZ2=-lbz2 \
    LF2="$LDFLAGS" \
    CF="$CFLAGS $CPPFLAGS -I. $DEFINES" \
    unzips
}

do_install() {
  make -j "$(nproc)" -f unix/Makefile prefix="${pkg_prefix}" install
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
    lilian/grep/3.0/20170624233820
    lilian/diffutils/3.6/20170624234540
    lilian/make/4.2.1/20170624234911
    lilian/patch/2.7.5/20170624234926
  )
fi

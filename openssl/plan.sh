pkg_name=openssl
_distname="$pkg_name"
pkg_origin=core
pkg_version=1.0.2n
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
OpenSSL is an open source project that provides a robust, commercial-grade, \
and full-featured toolkit for the Transport Layer Security (TLS) and Secure \
Sockets Layer (SSL) protocols. It is also a general-purpose cryptography \
library.\
"
pkg_upstream_url="https://www.openssl.org"
pkg_license=('OpenSSL')
pkg_source="https://www.openssl.org/source/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="370babb75f278c39e0c50e8c4e7493bc0f18db6867478341a832a982fd15a8fe"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
  lilian/zlib
  lilian/cacerts
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/sed
  lilian/grep
  lilian/perl
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

_common_prepare() {
  do_default_prepare

  # Set CA dir to `$pkg_prefix/ssl` by default and use the cacerts from the
  # `cacerts` package. Note that `patch(1)` is making backups because
  # we need an original for the test suite.
  sed -e "s,@prefix@,$pkg_prefix,g" \
      -e "s,@cacerts_prefix@,$(pkg_path_for cacerts),g" \
      "$PLAN_CONTEXT/ca-dir.patch" \
      | patch -p1 --backup

  # Purge the codebase (mostly tests) of the hardcoded reliance on `/bin/rm`.
  grep -lr '/bin/rm' . | while read -r f; do
    sed -e 's,/bin/rm,rm,g' -i "$f"
  done
}

source ../defaults.sh

do_prepare() {
  _common_prepare

  export BUILD_CC=gcc
  build_line "Setting BUILD_CC=$BUILD_CC"
}

do_build() {
  # Set PERL var for scripts in `do_check` that use Perl
  PERL=$(pkg_path_for lilian/perl)/bin/perl
  export PERL
  # shellcheck disable=SC2086
  ./config \
    --prefix="${pkg_prefix}" \
    --openssldir=ssl \
    no-idea \
    no-mdc2 \
    no-rc5 \
    zlib \
    shared \
    disable-gost \
    $CFLAGS \
    $LDFLAGS
  env CC= make depend
  make -j$(nproc) CC="$BUILD_CC"
}

do_check() {
  # Flip back to the original sources to satisfy the test suite, but keep the
  # final version for packaging.
  for f in apps/CA.pl.in apps/CA.sh apps/openssl.cnf; do
    cp -fv $f ${f}.final
    cp -fv ${f}.orig $f
  done

  make test

  # Finally, restore the final sources to their original locations.
  for f in apps/CA.pl.in apps/CA.sh apps/openssl.cnf; do
    cp -fv ${f}.final $f
  done
}

do_install() {
  do_default_install

  # Remove dependency on Perl at runtime
  rm -rfv "$pkg_prefix/ssl/misc" "$pkg_prefix/bin/c_rehash"
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
    lilian/grep/3.0/20170624233820
    lilian/perl/5.24.1/20170624234348
    lilian/diffutils/3.6/20170624234540
    lilian/make/4.2.1/20170624234911
    lilian/patch/2.7.5/20170624234926
  )
fi

pkg_name=wget
_distname="$pkg_name"
pkg_origin=core
pkg_version=1.19.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU Wget is a free software package for retrieving files using HTTP, HTTPS, \
FTP and FTPS the most widely-used Internet protocols.\
"
pkg_upstream_url="https://www.gnu.org/software/wget/"
pkg_license=('GPL-3.0+')
pkg_source="https://ftp.gnu.org/gnu/${_distname}/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="93fb96b0f48a20ff5be0d9d9d3c4a986b469cb853131f9d5fe4cc9cecbc8b5b5"
pkg_deps=(
  be/cacerts
  core/glibc
  be/openssl
  be/pcre
  be/zlib
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/flex
  be/gcc
  be/gettext
  be/grep
  be/make
  be/patch
  be/perl
  be/pkg-config
  be/sed
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  _wget_common_prepare
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-ssl=openssl \
    --without-libuuid
  make -j $(nproc)
}

do_install() {
  do_default_install

  cat <<EOF >> "$pkg_prefix/etc/wgetrc"

# Default root CA certs location
ca_certificate=$(pkg_path_for be/cacerts)/ssl/certs/cacert.pem
EOF
}

do_check() {
  PERL_MM_USE_DEFAULT=1 cpan HTTP:Daemon
  make check
}

_wget_common_prepare() {
  # Purge the codebase (mostly tests & build Perl scripts) of the hardcoded
  # reliance on `/usr/bin/env`.
  grep -lr '/usr/bin/env' . | while read -r f; do
    sed -e "s,/usr/bin/env,$(pkg_path_for coreutils)/bin/env,g" -i "$f"
  done
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
    lilian/perl/5.24.1/20170624234348
  )
fi

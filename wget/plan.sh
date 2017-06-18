pkg_name=wget
pkg_distname=$pkg_name
pkg_origin=lilian
pkg_version=1.19.1
pkg_license=('gplv3+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://ftp.gnu.org/gnu/$pkg_distname/${pkg_distname}-${pkg_version}.tar.xz
pkg_shasum=0c950b9671881222a4d385b013c9604e98a8025d1988529dfca0e93617744cd2
pkg_deps=(
  lilian/glibc lilian/libidn lilian/zlib
  lilian/openssl  lilian/cacerts
)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/sed
  lilian/grep lilian/pkg-config
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  _wget_common_prepare
}

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --with-ssl=openssl \
    --without-libuuid
  make -j $(nproc)
}

do_install() {
  do_default_install

  cat <<EOF >> $pkg_prefix/etc/wgetrc

# Default root CA certs location
ca_certificate=$(pkg_path_for cacerts)/ssl/certs/cacert.pem
EOF
}

_wget_common_prepare() {
  # Purge the codebase (mostly tests & build Perl scripts) of the hardcoded
  # reliance on `/usr/bin/env`.
  grep -lr '/usr/bin/env' . | while read f; do
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
  pkg_build_deps=(lilian/gcc lilian/pkg-config lilian/coreutils lilian/sed lilian/grep lilian/diffutils lilian/make lilian/patch)
fi

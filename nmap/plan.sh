pkg_name=nmap
pkg_origin=core
pkg_version=7.70
pkg_description="nmap is a free security scanner for network exploration and security audits"
pkg_upstream_url="https://nmap.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="https://nmap.org/dist/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="847b068955f792f4cc247593aca6dc3dc4aae12976169873247488de147a6e18"
pkg_deps=(
  core/glibc
  be/gcc-libs
  be/libpcap
  be/libssh2
  be/openssl
  be/pcre
  be/zlib
)
pkg_build_deps=(
  be/bzip2
  be/coreutils
  be/diffutils
  be/file
  be/gcc
  be/inetutils
  be/lua
  be/make
  be/openssh
  be/pkg-config
  be/readline
  lilian/which
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  export CFLAGS="${CFLAGS} -Wcpp"
  export CXXFLAGS="${CXXFLAGS} -Wcpp"

  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure --prefix="${pkg_prefix}" \
    --without-zenmap \
    --with-libdnet=included \
    --with-liblinear=included \
    --with-liblua="$(pkg_path_for "be/lua")" \
    --with-libpcre="$(pkg_path_for "be/pcre")" \
    --with-libssh2="$(pkg_path_for "be/libssh2")" \
    --with-libz="$(pkg_path_for "be/zlib")"
  make -j "$(nproc)"
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

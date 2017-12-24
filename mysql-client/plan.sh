pkg_name=mysql-client
pkg_origin=be
pkg_version=5.7.18
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0')
pkg_source=http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-${pkg_version}.tar.gz
pkg_shasum=0b5d71ed608656cd8181d3bb0434d3e36bac192899038dbdddf5a7594aaea1a2
pkg_upstream_url=https://www.mysql.com/
pkg_description="MySQL Client Tools"
pkg_deps=(
  lilian/coreutils
  lilian/gawk
  core/gcc-libs
  core/glibc
  lilian/grep
  lilian/inetutils
  lilian/ncurses
  lilian/openssl
  lilian/pcre
  lilian/perl
  lilian/procps-ng
  lilian/sed
)
pkg_build_deps=(
  lilian/boost/1.59.0
  lilian/cmake
  lilian/diffutils
  lilian/gcc
  lilian/make
  lilian/patch
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname="mysql-${pkg_version}"

source ../defaults.sh

do_build() {
  cmake . -DLOCAL_BOOST_DIR="$(pkg_path_for boost)" \
          -DBOOST_INCLUDE_DIR="$(pkg_path_for boost)/include" \
          -DWITH_BOOST="$(pkg_path_for boost)" \
          -DCURSES_LIBRARY="$(pkg_path_for ncurses)/lib/libcurses.so" \
          -DCURSES_INCLUDE_PATH="$(pkg_path_for ncurses)/include" \
          -DWITH_SSL=yes \
          -DOPENSSL_INCLUDE_DIR="$(pkg_path_for openssl)/include" \
          -DOPENSSL_LIBRARY="$(pkg_path_for openssl)/lib/libssl.so" \
          -DCRYPTO_LIBRARY="$(pkg_path_for openssl)/lib/libcrypto.so" \
          -DWITHOUT_SERVER:BOOL=ON \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_C_FLAGS="${CFLAGS}" \
          -DCMAKE_CXX_FLAGS="${CXXFLAGS} -fpermissive" \
          -DCMAKE_C_LINK_FLAGS="${LDFLAGS}" \
          -DCMAKE_CXX_LINK_FLAGS="${LDFLAGS}" \
          -DCMAKE_INSTALL_PREFIX="$pkg_prefix"
  make -j "$(nproc)"
}

do_install() {
  do_default_install

  # Remove things we don't need
  rm "$pkg_prefix/lib/"*.a "$pkg_prefix/bin/mysqld_"*

  fix_interpreter "$pkg_prefix/bin/mysqldumpslow" lilian/perl bin/perl
}

do_check() {
  ctest
}

pkg_name=mysql-client
pkg_origin=lilian
pkg_version=5.7.14
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0')
pkg_source=http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-${pkg_version}.tar.gz
pkg_shasum=f7415bdac2ca8bbccd77d4f22d8a0bdd7280b065bd646a71a506b77c7a8bd169
pkg_upstream_url=https://www.mysql.com/
pkg_description="MySQL Client Tools"
pkg_deps=(
  lilian/coreutils
  core/gawk
  core/gcc-libs
  core/glibc
  lilian/grep
  core/inetutils
  lilian/ncurses
  lilian/openssl 
  lilian/pcre
  lilian/perl
  core/procps-ng
  lilian/sed
)
pkg_build_deps=(
  core/boost159
  core/cmake
  lilian/diffutils
  lilian/gcc
  lilian/make
  lilian/patch
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname="mysql-${pkg_version}"

do_build() {
  cmake . -DLOCAL_BOOST_DIR="$(pkg_path_for core/boost159)" \
          -DBOOST_INCLUDE_DIR="$(pkg_path_for core/boost159)"/include \
          -DWITH_BOOST="$(pkg_path_for core/boost159)" \
          -DCURSES_LIBRARY="$(pkg_path_for lilian/ncurses)/lib/libcurses.so" \
          -DCURSES_INCLUDE_PATH="$(pkg_path_for lilian/ncurses)/include" \
          -DWITH_SSL=yes \
          -DOPENSSL_INCLUDE_DIR="$(pkg_path_for lilian/openssl )/include" \
          -DOPENSSL_LIBRARY="$(pkg_path_for lilian/openssl )/lib/libssl.so" \
          -DCRYPTO_LIBRARY="$(pkg_path_for lilian/openssl )/lib/libcrypto.so" \
          -DWITHOUT_SERVER:BOOL=ON \
          -DCMAKE_INSTALL_PREFIX="$pkg_prefix"
  make
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

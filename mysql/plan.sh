pkg_name=mysql
pkg_origin=be
pkg_version=5.7.18
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0')
pkg_source=http://dev.mysql.com/get/Downloads/MySQL-5.7/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=0b5d71ed608656cd8181d3bb0434d3e36bac192899038dbdddf5a7594aaea1a2
pkg_upstream_url=https://www.mysql.com/
pkg_description=$(cat << EOF
Starts MySQL with a basic configuration. Configurable at run time:

* root_password: the password for the mysql root user, empty by default
* app_username: the username for an application that will connect to the database server, false by default
* app_password: the password for the app user
* bind: the bind address to listen for connections, default 127.0.0.1

Set the app_username and app_password at runtime to have that user created, it will not be otherwise.
EOF
)
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
  lilian/bison
  lilian/boost/1.59.0
  lilian/cmake
  lilian/diffutils
  lilian/gcc
  lilian/make
  lilian/patch
)
pkg_svc_user="hab"
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_exports=(
  [port]=port
  [password]=app_password
  [username]=app_username
)

be_cxxstd="-std=gnu++14"
no_pie=true
source ../defaults.sh

do_build() {
  cmake . -DLOCAL_BOOST_DIR="$(pkg_path_for boost)" \
          -DBOOST_INCLUDE_DIR="$(pkg_path_for boost)/include" \
          -DWITH_BOOST="$(pkg_path_for boost)" \
          -DCURSES_INCLUDE_PATH="$(pkg_path_for ncurses)/include" \
          -DCURSES_LIBRARY="$(pkg_path_for ncurses)/lib/libcurses.so" \
          -DWITH_SSL=yes \
          -DOPENSSL_INCLUDE_DIR="$(pkg_path_for openssl )/include" \
          -DOPENSSL_LIBRARY="$(pkg_path_for openssl )/lib/libssl.so" \
          -DCRYPTO_LIBRARY="$(pkg_path_for openssl )/lib/libcrypto.so" \
          -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
          -DWITH_EMBEDDED_SERVER=no \
          -DWITH_EMBEDDED_SHARED_LIBRARY=no \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_C_FLAGS="${CFLAGS}" \
          -DCMAKE_CXX_FLAGS="${CXXFLAGS} -fpermissive" \
          -DCMAKE_C_LINK_FLAGS="${LDFLAGS}" \
          -DCMAKE_CXX_LINK_FLAGS="${LDFLAGS}"

  make -j "$(nproc)"
}

do_install() {
  do_default_install

  # Remove static libraries, tests, and other things we don't need
  rm -rf "$pkg_prefix/docs" "$pkg_prefix/man" "$pkg_prefix/mysql-test" \
    "$pkg_prefix"/lib/*.a

  fix_interpreter "$pkg_prefix/bin/mysqld_multi" lilian/perl bin/perl
  fix_interpreter "$pkg_prefix/bin/mysqldumpslow" lilian/perl bin/perl
}

do_check() {
  ctest
}

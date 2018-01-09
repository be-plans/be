pkg_name=percona-xtrabackup
pkg_origin=core
pkg_version=2.3.5
pkg_source=http://github.com/percona/percona-xtrabackup/archive/${pkg_name}-${pkg_version}.tar.gz
pkg_upstream_url=https://www.percona.com/software/mysql-database/percona-xtrabackup
pkg_shasum=1787623cb9ea331fb242992c4fcf3f88ee61045dcd42be027884bc7d373dcdae
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Percona xtrabackup utilities"
pkg_license=('GPL-2.0')
pkg_bin_dirs=(bin)
pkg_deps=(
  core/glibc be/gcc-libs be/bash
  lilian/iproute2 be/gnupg be/pkg-config
  be/ncurses be/vim be/curl
  lilian/libev be/openssl be/zlib
  be/libgcrypt lilian/libgpg-error be/libtool
)
pkg_build_deps=(
  be/m4 be/make be/gcc
  be/bison be/cmake lilian/mysql
  lilian/libaio lilian/boost/1.59.0
)
pkg_dirname=percona-xtrabackup-percona-xtrabackup-${pkg_version}

source ../defaults.sh

do_prepare() {
  do_default_prepare
  if [ -f CMakeCache.txt ]; then
    rm CMakeCache.txt
  fi
  sed -i 's/^.*abi_check.*$/#/' CMakeLists.txt
  export CXXFLAGS="$CFLAGS"
}

do_build() {
  export LD_LIBRARY_PATH GCRYPT_INCLUDE_DIR GCRYPT_LIB
  LD_LIBRARY_PATH="$(pkg_path_for be/libgcrypt)/lib"
  GCRYPT_INCLUDE_DIR=$(pkg_path_for be/libgcrypt)/lib
  GCRYPT_LIB=$(pkg_path_for be/libgcrypt)
  cmake . \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DCMAKE_PREFIX_PATH="$(pkg_path_for be/ncurses)" \
    -DWITH_BOOST="$(pkg_path_for lilian/boost/1.59.0)/include" \
    -DCURL_LIBRARY="$(pkg_path_for be/curl)/lib/libcurl.so" \
    -DCURL_INCLUDE_DIR="$(pkg_path_for be/curl)/include" \
    -DLIBEV_INCLUDE_DIRS="$(pkg_path_for lilian/libev)/include"	\
    -DGCRYPT_LIB="$(pkg_path_for be/libgcrypt)/lib/libgcrypt.so" \
    -DGCRYPT_INCLUDE_DIR="$(pkg_path_for be/libgcrypt)/include" \
    -DGPG_ERROR_LIB="$(pkg_path_for lilian/libgpg-error)/lib/libgpg-error.so" \
    -DLIBEV_LIB="$(pkg_path_for lilian/libev)/lib/libev.so" \
    -DCMAKE_CXX_FLAGS="$CXXFLAGS -fpermissive" \
    -DCMAKE_C_FLAGS="$CFLAGS" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_CONFIG=xtrabackup_release \
    -DWITH_MAN_PAGES=OFF


  make -j "$(nproc)"
}

do_install() {
  make -j "$(nproc)" install
}

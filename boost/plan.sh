pkg_name=boost
pkg_origin=lilian
pkg_description='Boost provides free peer-reviewed portable C++ source libraries.'
pkg_upstream_url='http://www.boost.org/'
pkg_version=1.61.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Boost Software License')
pkg_source=http://downloads.sourceforge.net/project/boost/boost/${pkg_version}/boost_1_61_0.tar.gz
pkg_shasum=a77c7cc660ec02704c6884fbb20c552d52d60a18f26573c9cee0788bf00ed7e6
pkg_dirname=boost_1_61_0

pkg_deps=(
  core/glibc
  core/gcc-libs
)

pkg_build_deps=(
  core/glibc
  core/gcc-libs
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  core/python2
  core/libxml2
  core/libxslt
  lilian/openssl 
  core/which
  lilian/zlib
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  ./bootstrap.sh --prefix="$pkg_prefix"
}

do_install() {
  export NO_BZIP2=1
  export ZLIB_LIBPATH
  ZLIB_LIBPATH="$(pkg_path_for lilian/zlib)/lib"
  export ZLIB_INCLUDE
  ZLIB_INCLUDE="$(pkg_path_for lilian/zlib)/include"
  ./b2 install --prefix="$pkg_prefix" -q --debug-configuration
}

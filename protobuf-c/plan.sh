pkg_origin=lilian
pkg_name=protobuf-c
pkg_version=0.15
pkg_dirname=protobuf-c-ddabb041b38ce0ab1fa8e91734e79b206556a661
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source=https://github.com/protobuf-c/protobuf-c/archive/ddabb041b38ce0ab1fa8e91734e79b206556a661.tar.gz
pkg_shasum=3b7ca04389c0721130814fd9e99a2068375c1d71163f153c142c1fdcea64c83c
pkg_deps=(core/gcc-libs lilian/protobuf/2.5.0 lilian/zlib)
pkg_build_deps=(
  lilian/gcc lilian/make lilian/autoconf
  lilian/automake lilian/libtool lilian/m4
  lilian/patch
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/protobuf-c/protobuf-c
pkg_description="Protocol Buffers implementation in C"

source ../defaults.sh

do_prepare () {
  patch -p1 -i "${PLAN_CONTEXT}/automake.patch"
}

do_build () {
  export CXXFLAGS=$CFLAGS
  # autogen runs ./configure with all flags passed to it.
  ./autogen.sh --prefix="$pkg_prefix"

  make -j "$(nproc)"
}

do_check () {
  make check
}

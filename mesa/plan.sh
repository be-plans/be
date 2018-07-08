pkg_name=mesa
pkg_origin=core
pkg_version=17.2.5
pkg_description="The Mesa 3D Graphics Library"
pkg_upstream_url="https://www.mesa3d.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://mesa.freedesktop.org/archive/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=7f7f914b7b9ea0b15f2d9d01a4375e311b0e90e55683b8e8a67ce8691eb1070f
pkg_deps=(
  lilian/elfutils
  lilian/expat
  lilian/gcc-libs
  core/glibc
  lilian/libdrm
  lilian/libpciaccess
  lilian/libxau
  lilian/libxcb
  lilian/libxdamage
  lilian/libxdmcp
  lilian/libxext
  lilian/libxfixes
  lilian/libxshmfence
  lilian/xlib
  lilian/zlib
)
pkg_build_deps=(
  lilian/bison
  lilian/damageproto
  lilian/diffutils
  lilian/dri2proto
  lilian/file
  lilian/fixesproto
  lilian/flex
  lilian/gcc
  lilian/glproto
  lilian/kbproto
  lilian/libpthread-stubs
  lilian/llvm
  lilian/make
  lilian/pkg-config
  lilian/python2
  lilian/xextproto
  lilian/xproto
)
pkg_include_dirs=(include)
pkg_lib_dirs=(
  lib
  lib/dri
)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --enable-gles1 \
    --enable-gles2 \
    --enable-llvm  \
    --disable-llvm-shared-libs
  make
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

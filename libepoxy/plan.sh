pkg_name=libepoxy
pkg_origin=core
pkg_version=1.4.3
pkg_description="Epoxy is a library for handling OpenGL function pointer management for you"
pkg_upstream_url="https://github.com/anholt/libepoxy"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/anholt/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=0b808a06c9685a62fca34b680abb8bc7fb2fda074478e329b063c1f872b826f6
pkg_deps=(
  core/glibc
  lilian/libdrm # not linked to bins/libs
  lilian/libxau # not linked to bins/libs
  lilian/libxcb # not linked to bins/libs
  lilian/libxdamage # not linked to bins/libs
  lilian/libxdmcp # not linked to bins/libs
  lilian/libxext # not linked to bins/libs
  lilian/libxfixes # not linked to bins/libs
  lilian/mesa # not linked to bins/libs
  lilian/xlib # not linked to bins/libs
)
pkg_build_deps=(
  lilian/damageproto
  lilian/fixesproto
  lilian/gcc
  lilian/kbproto
  lilian/libpthread-stubs
  lilian/meson
  lilian/ninja
  lilian/pkg-config
  lilian/python
  lilian/xextproto
  lilian/xproto
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  mkdir _build
  pushd _build > /dev/null
    meson --prefix="$pkg_prefix" \
      --buildtype release
    ninja
  popd > /dev/null
}

do_install() {
  pushd _build > /dev/null
    ninja install
  popd > /dev/null
}

pkg_name=libxcomposite
pkg_origin=core
pkg_version=0.4.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 C Bindings for Composite extension"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_dirname="libXcomposite-${pkg_version}"
pkg_source="https://www.x.org/releases/individual/lib/${pkg_dirname}.tar.bz2"
pkg_shasum="ede250cd207d8bee4a338265c3007d7a68d5aca791b6ac41af18e9a2aeb34178"
pkg_deps=(
  core/glibc
  lilian/libxau
  lilian/libxcb
  lilian/libxdmcp
  lilian/xlib
)
pkg_build_deps=(
  lilian/compositeproto
  lilian/diffutils
  lilian/file
  lilian/fixesproto
  lilian/gcc
  lilian/kbproto
  lilian/libpthread-stubs
  lilian/libxfixes
  lilian/make
  lilian/pkg-config
  lilian/xextproto
  lilian/xproto
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  # The configure script expects `file` binaries to be in `/usr/bin`
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_end() {
  # Clean up
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

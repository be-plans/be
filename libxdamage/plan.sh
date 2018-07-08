pkg_name=libxdamage
pkg_origin=core
pkg_version=1.1.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 C Bindings"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_dirname="libXdamage-${pkg_version}"
pkg_source="https://www.x.org/releases/individual/lib/${pkg_dirname}.tar.bz2"
pkg_shasum="7c3fe7c657e83547f4822bfde30a90d84524efb56365448768409b77f05355ad"
pkg_deps=(
  core/glibc
  lilian/libxau
  lilian/libxcb
  lilian/libxdmcp
  lilian/libxfixes
  lilian/xlib
)
pkg_build_deps=(
  lilian/damageproto
  lilian/diffutils
  lilian/file
  lilian/fixesproto
  lilian/gcc
  lilian/kbproto
  lilian/libpthread-stubs
  lilian/make
  lilian/pkg-config
  lilian/util-macros
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

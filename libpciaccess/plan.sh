pkg_name=libpciaccess
pkg_origin=core
pkg_version=0.14
pkg_description="Direct Rendering Manager"
pkg_upstream_url="https://dri.freedesktop.org/wiki/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://www.x.org/archive/individual/lib/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=8d86e64893917be3dfb1c5e837888d1275399c818783474002203d751312b03c
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  lilian/diffutils
  lilian/file
  lilian/gcc
  lilian/make
  lilian/pkg-config
  lilian/util-macros
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

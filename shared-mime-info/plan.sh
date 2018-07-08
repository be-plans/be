pkg_name=shared-mime-info
pkg_origin=core
pkg_version=1.9
pkg_description="The shared-mime-info package contains the core database of common types and the update-mime-database command used to extend it"
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/shared-mime-info/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="http://freedesktop.org/~hadess/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=5c0133ec4e228e41bdf52f726d271a2d821499c2ab97afd3aa3d6cf43efcdc83
pkg_deps=(
  lilian/glib
  core/glibc
  lilian/libxml2
  lilian/pcre
  lilian/zlib
)
pkg_build_deps=(
  lilian/cpanminus
  lilian/expat
  lilian/gcc
  lilian/gettext
  lilian/intltool
  lilian/make
  lilian/perl
  lilian/pkg-config
)
pkg_bin_dirs=(bin)

do_prepare() {
  do_default_prepare

  cpanm XML::Parser --configure-args="EXPATLIBPATH=$(pkg_path_for lilian/expat)/lib export EXPATINCPATH=$(pkg_path_for lilian/expat)/include"
}

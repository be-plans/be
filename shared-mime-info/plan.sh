pkg_name=shared-mime-info
pkg_origin=be
pkg_version=1.9
pkg_description="The shared-mime-info package contains the core database of common types and the update-mime-database command used to extend it"
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/shared-mime-info/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="http://freedesktop.org/~hadess/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=5c0133ec4e228e41bdf52f726d271a2d821499c2ab97afd3aa3d6cf43efcdc83
pkg_deps=(
  core/glib
  core/glibc
  core/libxml2
  core/pcre
  core/zlib
)
pkg_build_deps=(
  core/cpanminus
  core/expat
  core/gcc
  core/gettext
  core/intltool
  core/make
  core/perl
  core/pkg-config
)
pkg_bin_dirs=(bin)

do_prepare() {
  do_default_prepare

  cpanm XML::Parser --configure-args="EXPATLIBPATH=$(pkg_path_for core/expat)/lib export EXPATINCPATH=$(pkg_path_for core/expat)/include"
}

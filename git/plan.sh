pkg_name=git
pkg_version=2.14.2
pkg_origin=lilian
pkg_description="Git is a free and open source distributed version control
  system designed to handle everything from small to very large projects with
  speed and efficiency."
pkg_upstream_url=https://git-scm.com/
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.kernel.org/pub/software/scm/git/${pkg_name}-${pkg_version}.tar.xz
pkg_filename=${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=a03a12331d4f9b0f71733db9f47e1232d4ddce00e7f2a6e20f6ec9a19ce5ff61
pkg_deps=(
  lilian/cacerts
  lilian/curl
  lilian/expat
  lilian/gettext
  core/gcc-libs
  core/glibc
  lilian/openssh
  lilian/perl
  lilian/zlib
)
pkg_build_deps=(lilian/make lilian/gcc)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  local perl_path
  perl_path="$(pkg_path_for perl)/bin/perl"
  sed -e "s#/usr/bin/perl#$perl_path#g" -i Makefile
}

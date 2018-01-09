pkg_name=git
pkg_version=2.15.1
pkg_origin=core
pkg_description="Git is a free and open source distributed version control
  system designed to handle everything from small to very large projects with
  speed and efficiency."
pkg_upstream_url=https://git-scm.com/
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.kernel.org/pub/software/scm/git/${pkg_name}-${pkg_version}.tar.xz
pkg_filename=${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=999c90fd7d45066992cdb87dda35bdff6dfc1d01496118ea718dfb866da4045c
pkg_deps=(
  be/cacerts
  be/curl
  be/expat
  be/gettext
  be/gcc-libs
  core/glibc
  be/openssh
  be/perl
  be/zlib
)
pkg_build_deps=(
  be/make
  be/gcc
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  local perl_path
  perl_path="$(pkg_path_for perl)/bin/perl"
  sed -e "s#/usr/bin/perl#$perl_path#g" -i Makefile
}

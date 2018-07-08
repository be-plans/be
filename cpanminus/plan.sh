pkg_name=cpanminus
pkg_version=1.7043
pkg_origin=core
pkg_license=('Artistic-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="cpanminus is a script to get, unpack, build and install modules from CPAN and does nothing else."
pkg_upstream_url=http://cpanmin.us
pkg_source=https://github.com/miyagawa/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-${pkg_version}
pkg_shasum=7f52a6487a2462b658164f431ae6cc0b78685df3bccfe4139823372cb5b5fd42
pkg_deps=(
  core/glibc
  lilian/perl
  lilian/local-lib
)
pkg_build_deps=(
  lilian/gcc
  lilian/make
  lilian/coreutils
  lilian/perl
  lilian/local-lib
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  return 0
}

do_install() {
  # Create a new lib dir in our pacakge for cpanm to house all of its libs
  eval $(perl -Mlocal::lib=${pkg_prefix})

  # cpanm prioritizes the local::lib location for an install dir
  cat cpanm | perl - App::cpanminus
}

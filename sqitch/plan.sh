pkg_name=sqitch
pkg_version=0.9995
pkg_origin=core
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Sqitch is a database change management application."
pkg_upstream_url=http://sqitch.org/
pkg_source=https://cpan.metacpan.org/authors/id/D/DW/DWHEELER/App-Sqitch-${pkg_version}.tar.gz
pkg_filename=App-Sqitch-${pkg_version}.tar.gz
pkg_dirname=App-Sqitch-${pkg_version}
pkg_shasum=c29b4610ce43bd43ecfa39188f4cbb00b38c390136fcdd9984142efd99eba292
pkg_deps=(
  core/glibc be/perl lilian/local-lib
  lilian/cpanminus
)
pkg_build_deps=(
  be/gcc be/make be/coreutils
  be/perl lilian/local-lib lilian/cpanminus
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

#TODO: This could be built
source ../defaults.sh

do_prepare() {
  do_default_prepare
  eval "$(perl -I$(pkg_path_for lilian/local-lib)/lib/perl5 -Mlocal::lib=$(pkg_path_for lilian/local-lib))"
  # Create a new lib dir in our pacakge for cpanm to house all of its libs
  eval $(perl -Mlocal::lib=${pkg_prefix})

  cpanm Module::Build
}

do_build() {
  perl Build.PL
}

do_install() {
  export PERL_MM_USE_DEFAULT=1
  ./Build installdeps --cpan_client 'cpanm -v --notest' --defaultdeps
  ./Build
  ./Build install

  for file in ${pkg_prefix}/bin/*; do
    sed -i "1 s,.*,& -I${pkg_prefix}/lib/perl5," $file
  done
}

do_check() {
  ./Build test
}

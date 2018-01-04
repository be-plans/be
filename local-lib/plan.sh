pkg_name=local-lib
pkg_version=2.000023
pkg_origin=core
pkg_license=('Artistic-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="create and use a local lib/ for perl modules with PERL5LIB"
pkg_upstream_url='https://github.com/Perl-Toolchain-Gang/local-lib'
pkg_source=http://search.cpan.org/CPAN/authors/id/H/HA/HAARG/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-${pkg_version}
pkg_shasum=0cf6f5916fc5ae86ef30c5df87414fd3587eff40642bc85ab17a59047bb82099
pkg_deps=(core/glibc be/perl)
pkg_build_deps=(
  be/gcc be/make be/coreutils
  be/perl
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  perl Makefile.PL --bootstrap=${pkg_prefix} --no-manpages
}

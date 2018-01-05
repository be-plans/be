pkg_name=local-lib
pkg_version=2.000024
pkg_origin=core
pkg_license=('Artistic-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="create and use a local lib/ for perl modules with PERL5LIB"
pkg_upstream_url='https://github.com/Perl-Toolchain-Gang/local-lib'
pkg_source=http://search.cpan.org/CPAN/authors/id/H/HA/HAARG/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-${pkg_version}
pkg_shasum=2e9b917bd48a0615e42633b2a327494e04610d8f710765b9493d306cead98a05
pkg_deps=(
  core/glibc
  be/perl
)
pkg_build_deps=(
  be/gcc
  be/make
  be/coreutils
  be/perl
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_setup_environment() {
  local -r inc_path="${pkg_prefix}/lib/perl5"
  eval "$(perl -I${inc_path} -Mlocal::lib=${pkg_prefix})"

  # Avoid inserting an empty ":" at the beginning of the path
  if [ -z "${PERL5LIB}" ]; then
    set_runtime_env -f PERL5LIB "${inc_path}"
  else
    # Avoiding: PERL5LIB=some_path:${inc_path}/invalid_path:some_other_path
    local -r regex="^([ tab]*${inc_path}[ tab]*)$|^([ tab]*${inc_path}:{1})|:{1}${inc_path}:{1}|(:{1}${inc_path}[ tab]*)$"

    # If the path is already exported, then skip
    if   [ -z "$(echo "${PERLLIB}"  | grep -E "${regex}")" ] \
      && [ -z "$(echo "${PERL5LIB}" | grep -E "${regex}")" ]; then
      set_runtime_env -f PERL5LIB "${PERL5LIB}:${inc_path}"
    fi
  fi
}

do_build() {
  perl Makefile.PL --bootstrap=${pkg_prefix} --no-manpages
}

pkg_name=sshpass
pkg_origin=core
pkg_version="1.06"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0-or-later")
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_source="https://downloads.sourceforge.net/project/${pkg_name}/${pkg_name}/${pkg_version}/${pkg_filename}"
pkg_shasum="c6324fcee608b99a58f9870157dfa754837f8c48be3df0f5e2f3accf145dee60"
pkg_build_deps=(lilian/make lilian/gcc)
pkg_bin_dirs=(bin)
pkg_description="Non-interactive ssh password auth"
pkg_upstream_url="https://sourceforge.net/projects/sshpass/"

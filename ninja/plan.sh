pkg_name=ninja
pkg_origin=lilian
pkg_version=1.7.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://ninja-build.org/
pkg_description="A small build system with a focus on speed"
pkg_licenses=('Apache-2.0')
pkg_source=https://github.com/ninja-build/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=2edda0a5421ace3cf428309211270772dd35a91af60c96f93f90df6bc41b16d9
pkg_deps=(lilian/glibc lilian/gcc-libs)
pkg_build_deps=(lilian/gcc lilian/python lilian/re2c)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  python configure.py --bootstrap
}

do_install() {
  mkdir -p "$pkg_prefix/bin/"
  cp ninja "$pkg_prefix/bin/"
}

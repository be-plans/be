pkg_name=pax-utils
pkg_version=1.2.3
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL')
pkg_description="ELF related utils for ELF 32/64 binaries that can check files
  for security relevant properties"
pkg_upstream_url='http://hardened.gentoo.org/pax-utils.xml'
pkg_source="http://distfiles.gentoo.org/distfiles/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="d231b1a34aea2b9205c24fada79a8251d4c3fbcce49367fc055fe43e4c9783b2"
pkg_deps=(
  be/bash
  core/glibc
  be/libcap
  be/python
)
pkg_build_deps=(
  be/diffutils
  be/gcc
  be/make
  be/pkg-config
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./configure --prefix="$pkg_prefix" \
              --with-caps \
              --with-python="$(pkg_path_for python)"
  make -j $(nproc)
}

do_check() {
  make check USE_PYTHON='no'
}

do_install() {
  do_default_install
  fix_interpreter "$pkg_prefix/bin/*" be/bash bin/bash
}

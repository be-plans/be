pkg_name=libassuan
pkg_origin=be
pkg_version=2.4.3
pkg_license=('lgplv2+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=22843a3bdb256f59be49842abf24da76700354293a066d82ade8134bb5aa2b71
pkg_deps=(core/glibc lilian/libgpg-error)
pkg_build_deps=(
  be/gcc lilian/coreutils lilian/sed
  lilian/bison lilian/flex lilian/grep
  lilian/bash lilian/gawk lilian/libtool
  lilian/diffutils lilian/findutils lilian/xz
  lilian/gettext lilian/gzip lilian/make
  lilian/patch lilian/texinfo lilian/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --with-libgpg-error-prefix=$(pkg_path_for libgpg-error) \
    --enable-static \
    --enable-shared
  make -j $(nproc)
}

do_check() {
  make check
}

do_strip() {
  return 0
}

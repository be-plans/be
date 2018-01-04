pkg_name=libassuan
pkg_origin=core
pkg_version=2.4.3
pkg_license=('lgplv2+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=22843a3bdb256f59be49842abf24da76700354293a066d82ade8134bb5aa2b71
pkg_deps=(core/glibc lilian/libgpg-error)
pkg_build_deps=(
  be/gcc be/coreutils be/sed
  be/bison be/flex be/grep
  be/bash be/gawk be/libtool
  be/diffutils be/findutils be/xz
  be/gettext be/gzip be/make
  be/patch be/texinfo be/util-linux
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

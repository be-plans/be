pkg_name=libgpg-error
pkg_origin=core
pkg_version=1.27
pkg_license=('lgplv2+')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=4f93aac6fecb7da2b92871bb9ee33032be6a87b174f54abf8ddf0911a22d29d2
pkg_deps=(core/glibc)
pkg_build_deps=(
  be/gcc be/coreutils be/sed
  lilian/bison lilian/flex lilian/grep
  lilian/bash lilian/gawk lilian/libtool
  be/diffutils lilian/findutils lilian/xz
  lilian/gettext lilian/gzip be/make
  be/patch lilian/texinfo lilian/util-linux
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix=${pkg_prefix} \
    --enable-static \
    --enable-shared
  make -j $(nproc)
}

do_check() {
  make check
}

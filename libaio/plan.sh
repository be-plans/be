pkg_name=libaio
pkg_origin=lilian
pkg_version=0.3.110
pkg_license=('LGPL')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://ftp.de.debian.org/debian/pool/main/liba/${pkg_name}/${pkg_name}_${pkg_version}.orig.tar.gz
pkg_shasum=e019028e631725729376250e32b473012f7cb68e1f7275bfc1bbcdd0f8745f7e
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_build_deps=(lilian/coreutils lilian/gcc lilian/make)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

no_pie=true
source ../defaults.sh

do_build() {
  make -j "$(nproc)"
}

do_install() {
  make -j "$(nproc)" install prefix=${pkg_prefix}
}

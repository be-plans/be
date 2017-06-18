pkg_name=libxml2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_origin=lilian
pkg_version=2.9.4
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://xmlsoft.org/sources/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ffb911191e509b966deb55de705387f14156e1a56b21824357cdf0053233633c
pkg_deps=(lilian/glibc lilian/zlib lilian/python)
pkg_build_deps=(lilian/coreutils lilian/make lilian/gcc lilian/m4)
pkg_filename=${pkg_name}-${pkg_version}.tar.xz
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./configure --prefix=${pkg_prefix} \
    --with-python="$(pkg_path_for python)" \
    --with-zlib="$(pkg_path_for zlib)"

  make -j "$(nproc)"
}

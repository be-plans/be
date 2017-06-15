pkg_name=gpgme
pkg_origin=lilian
pkg_version=1.9.0
pkg_license=('LGPL')
pkg_source=https://www.gnupg.org/ftp/gcrypt/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=1b29fedb8bfad775e70eafac5b0590621683b2d9869db994568e6401f4034ceb
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_deps=(core/glibc lilian/libassuan lilian/libgpg-error)
pkg_build_deps=(lilian/gcc lilian/coreutils lilian/make)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --with-libgpg-error-prefix=$(pkg_path_for libgpg-error) \
    --with-libassuan-prefix=$(pkg_path_for libassuan)
  make -j $(nproc)
}

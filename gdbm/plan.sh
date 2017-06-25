pkg_name=gdbm
pkg_origin=lilian
pkg_version=1.13
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv3+')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=9d252cbd7d793f7b12bcceaddda98d257c14f4d1890d851c386c37207000a253
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/coreutils lilian/diffutils lilian/patch lilian/make lilian/gcc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --enable-libgdbm-compat
  make -j $(nproc)
}

do_check() {
  make check
}

do_install() {
  do_default_install

  # create symlinks for compatibility
  install -dm755 ${pkg_prefix}/include/gdbm
  ln -sf ../gdbm.h ${pkg_prefix}/include/gdbm/gdbm.h
  ln -sf ../ndbm.h ${pkg_prefix}/include/gdbm/ndbm.h
  ln -sf ../dbm.h  ${pkg_prefix}/include/gdbm/dbm.h
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/coreutils)
fi

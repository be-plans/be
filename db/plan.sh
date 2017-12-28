pkg_name=db
pkg_origin=be
pkg_version=6.2.32
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('custom')
pkg_source=http://download.oracle.com/berkeley-db/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=a9c5e2b004a5777aa03510cfe5cd766a4a3b777713406b02809c17c8e0e7a8fb
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(lilian/coreutils lilian/diffutils lilian/patch lilian/make be/gcc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  pushd build_unix > /dev/null
  ../dist/configure \
    --prefix=$pkg_prefix \
    --enable-compat185 \
    --enable-cxx \
    --enable-dbm \
    --enable-stl
  make LIBSO_LIBS=-lpthread -j $(nproc)
  popd > /dev/null
}

do_install() {
  pushd build_unix > /dev/null
  do_default_install
  popd > /dev/null

  # Install license file
  install -Dm644 LICENSE "$pkg_prefix/share/licenses/LICENSE"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc lilian/coreutils)
fi

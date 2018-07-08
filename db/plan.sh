pkg_name=db
pkg_origin=core
pkg_version=5.3.28
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Berkeley DB is a family of embedded key-value database libraries providing \
scalable high-performance data management services to applications.\
"
pkg_upstream_url="http://www.oracle.com/technetwork/database/database-technologies/berkeleydb/overview/index.html"
pkg_license=('custom')
pkg_source="http://download.oracle.com/berkeley-db/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="e0a992d740709892e81f9d93f06daf305cf73fb81b545afe72478043172c3628"
pkg_deps=(
  core/glibc
  lilian/gcc-libs
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  pushd build_unix > /dev/null
  ../dist/configure \
    --prefix="${pkg_prefix}" \
    --enable-compat185 \
    --enable-cxx \
    --enable-dbm \
    --enable-stl
  make LIBSO_LIBS=-lpthread -j"$(nproc)"
  popd > /dev/null
}

do_install() {
  pushd build_unix > /dev/null
  do_default_install
  make uninstall_docs
  popd > /dev/null

  # Install license file
  install -Dm644 LICENSE "${pkg_prefix}/share/licenses/LICENSE"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    lilian/gcc/7.1.0/20170624225400
    lilian/coreutils/8.27/20170624233515
  )
fi

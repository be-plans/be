pkg_name=llvm
pkg_origin=lilian
pkg_version=4.0.0
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url=http://llvm.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename=${pkg_name}-${pkg_version}.src.tar.xz
pkg_source=http://llvm.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz
pkg_shasum=8d10511df96e73b8ff9e7abbfb4d4d432edbdbe965f1f4f07afaf370b8a533be
pkg_build_deps=(
  lilian/cmake
  lilian/coreutils
  lilian/diffutils
  lilian/gcc
  lilian/ninja
  lilian/python
)
pkg_deps=(
  core/gcc-libs
  core/glibc
  lilian/zlib
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_unpack() {
  # The tarball's structure has `.src` as part of the base directory.
  # This reimplements a large portion of the default unpack, only to
  # add `--strip` to the tar command.
  # There may be some more awesome way to do this - I don't know that yet.
  build_line "Unpacking $pkg_filename to custom cache dir"
  local source_file=$HAB_CACHE_SRC_PATH/$pkg_filename
  local unpack_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}
  mkdir -p "$unpack_dir"
  pushd "$unpack_dir" > /dev/null
  tar xf "$source_file" --strip 1
  popd > /dev/null

  # Download Clang frontend and place it in the correct place
  build_line "Unpacking Clang FrontEnd to custom cache dir"
  download_file http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz \
    cfe-${pkg_version}.src.tar.xz \
    cea5f88ebddb30e296ca89130c83b9d46c2d833685e2912303c828054c4dc98a

  local clang_src_dir="$unpack_dir/tools/clang"
  mkdir -p "$clang_src_dir"
  pushd "$clang_src_dir" > /dev/null
  tar xf "$HAB_CACHE_SRC_PATH/cfe-${pkg_version}.src.tar.xz" --strip 1
  popd > /dev/null
}

compiler_flags() {
  local -r optimizations="-fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} -Wno-error "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} -Wno-error "
  export CPPFLAGS="${CPPFLAGS} -Wno-error"
}

do_prepare() {
  do_default_prepare
  compiler_flags
}

do_build() {
  mkdir -p build
  cd build || exit
  cmake -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" -DCMAKE_BUILD_TYPE=Release -G "Ninja" ../
  ninja -v
}

do_check() {
  cd build || exit
  ninja check
}

do_install() {
  cd build || exit
  ninja install
}

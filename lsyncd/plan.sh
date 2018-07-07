pkg_name=lsyncd
pkg_origin=core
pkg_version=2.2.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="https://github.com/axkibe/$pkg_name/archive/release-$pkg_version.tar.gz"
pkg_dirname="$pkg_name-release-$pkg_version"
pkg_shasum="f41969454a17f9441a9b1809bb251235631768393bf5d29ad8e8142670ae4735"
pkg_deps=(core/glibc)
pkg_build_deps=(
  be/cmake
  be/gcc
  be/lua
  be/make
)
pkg_bin_dirs=(bin)
pkg_description="Lsyncd watches a local directory trees event monitor interface (inotify or fsevents)"
pkg_upstream_url="https://axkibe.github.io/lsyncd/"

source ../defaults.sh

do_build() {
  cmake \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DLUA_LIBRARIES="lua -ldl -lm" \
    -DLUA_INCLUDE_DIR="$(pkg_path_for lua)/include" \
    -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" \
    .
  cmake --build . -- -v
}

do_install() {
  cmake --build . --target install
}
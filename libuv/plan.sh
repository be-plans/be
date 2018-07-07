pkg_name=libuv
pkg_origin=core
pkg_version="1.16.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/libuv/libuv/archive/v${pkg_version}.tar.gz"
pkg_shasum="61f7937eef924da0dc386c038b8a4e1fc4f1803af966e1ecf640fb0e1cb5043b"
pkg_deps=(core/glibc)
pkg_build_deps=(
  be/autoconf
  be/automake
  be/diffutils
  be/file
  be/gcc
  be/libtool
  be/m4
  be/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_description="libuv is a multi-platform support library with a focus on asynchronous I/O."
pkg_upstream_url="http://libuv.org/"

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  sh autogen.sh
  do_default_build
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

do_check() {
  make check
}

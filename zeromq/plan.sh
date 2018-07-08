pkg_name=zeromq
pkg_origin=core
pkg_version=4.2.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="ZeroMQ core engine in C++, implements ZMTP/3.1"
pkg_upstream_url=http://zeromq.org
pkg_license=('LGPL')
pkg_source=https://github.com/zeromq/libzmq/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=cc9090ba35713d59bb2f7d7965f877036c49c5558ea0c290b0dcc6f2a17e489f
pkg_deps=(core/glibc lilian/gcc-libs lilian/libsodium)
pkg_build_deps=(lilian/gcc lilian/diffutils lilian/coreutils lilian/make lilian/pkg-config lilian/patchelf lilian/busybox-static lilian/shadow)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_install() {
  do_default_install
    # shellcheck disable=SC2038
  find "$pkg_prefix/lib" -name "*.so" | xargs -I '%' patchelf --set-rpath "$LD_RUN_PATH" %
}

do_check() {
  # Note: tests/test_filter_ipc.cpp:144 runs a test against a user in another group. When running
  # `id`, it shows that the `root` user belongs to `dialout`.  However the test still fails.
  # Therefore we must ensure the `root` user really is part of dialout group.
  gpasswd -a root dialout

  make check

  # clean this up by going back to default
  gpasswd -d root dialout
}

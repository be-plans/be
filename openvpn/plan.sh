pkg_name=openvpn
pkg_origin=core
pkg_version=2.4.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source=https://swupdate.openvpn.org/community/releases/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=df5c4f384b7df6b08a2f6fa8a84b9fd382baf59c2cef1836f82e2a7f62f1bff9
pkg_deps=(
  core/glibc be/openssl lilian/lzo
)
pkg_build_deps=(
  be/gcc be/coreutils be/make
  be/busybox-static
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure \
    --disable-plugin-auth-pam \
    --prefix=${pkg_prefix} \
    --exec-prefix=${pkg_prefix} \
    --sbindir=${pkg_prefix}/bin \
    --enable-iproute2

  make -j "$(nproc)"
}

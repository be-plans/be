pkg_name=systemd
pkg_origin=core
pkg_version="233"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="systemd is an init system used in Linux distributions to \
bootstrap the user space. Subsequently to booting, it is used to manage system \
processes."
pkg_license=('LGPL-2.1')
pkg_source="https://github.com/systemd/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_upstream_url="https://github.com/systemd/systemd"
pkg_shasum="8b3e99da3d4164b66581830a7f2436c0c8fe697b5fbdc3927bdb960646be0083"
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib var/lib usr/lib)
pkg_deps=(
  core/glibc
  be/libcap
  lilian/lz4
  be/util-linux
)
pkg_svc_user=root
pkg_svc_group=root
pkg_build_deps=(
  be/autoconf
  be/automake
  be/cpanminus
  be/dbus
  be/expat
  be/gcc
  be/gcc-libs
  be/gettext
  core/glibc
  be/gperf
  be/intltool
  be/libtool
  lilian/libxslt
  be/local-lib
  lilian/lz4
  be/m4
  be/make
  be/perl
  be/pkg-config
  be/util-linux
  be/xz
)

source ../defaults.sh

do_build() {
  export ACLOCAL_FLAGS
  ACLOCAL_FLAGS="-I $(pkg_path_for be/pkg-config)/share/aclocal \
    -I$(pkg_path_for be/libtool)/share/aclocal \
    -I$(pkg_path_for be/intltool)/share/aclocal \
    -I$(pkg_path_for be/gettext)/share/aclocal"
  ./autogen.sh
  ./configure \
    --prefix="${pkg_prefix}" \
    --disable-manpages \
    --without-python \
    --with-rootprefix="${pkg_prefix}" \
    --libdir="${pkg_prefix}/usr/lib" \
    --with-rootlibdir="${pkg_prefix}/lib" \
    --with-dbuspolicydir="${pkg_prefix}/etc/dbus-1/system.d" \
    --with-dbussystemservicedir="${pkg_prefix}/share/dbus-1/system-services" \
    --with-dbussessionservicedir="${pkg_prefix}/share/dbus-1/services"

  make -j "$(nproc)"
}

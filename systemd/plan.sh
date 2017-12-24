pkg_name=systemd
pkg_origin=be
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
  lilian/libcap
  lilian/lz4
  lilian/util-linux
)
pkg_svc_user=root
pkg_svc_group=root
pkg_build_deps=(
  lilian/autoconf
  lilian/automake
  lilian/cpanminus
  lilian/dbus
  lilian/expat
  lilian/gcc
  core/gcc-libs
  lilian/gettext
  core/glibc
  lilian/gperf
  lilian/intltool
  lilian/libtool
  lilian/libxslt
  lilian/local-lib
  lilian/lz4
  lilian/m4
  lilian/make
  lilian/perl
  lilian/pkg-config
  lilian/util-linux
  lilian/xz
)

do_prepare() {
  eval "$(perl -I"$(pkg_path_for core/local-lib)/lib/perl5" -Mlocal::lib="$(pkg_path_for core/local-lib)")"
  eval "$(perl -I"$(pkg_path_for lilian/intltool)/lib/lib/perl5" -Mlocal::lib="$(pkg_path_for lilian/intltool)/lib")"
}

source ../defaults.sh

do_build() {
  export ACLOCAL_FLAGS
  ACLOCAL_FLAGS="-I $(pkg_path_for core/pkg-config)/share/aclocal \
    -I$(pkg_path_for core/libtool)/share/aclocal \
    -I$(pkg_path_for lilian/intltool)/share/aclocal \
    -I$(pkg_path_for core/gettext)/share/aclocal"
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

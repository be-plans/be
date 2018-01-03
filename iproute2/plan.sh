pkg_name=iproute2
pkg_origin=core
pkg_version=4.11.0
pkg_source=https://www.kernel.org/pub/linux/utils/net/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=72671028bda696d0cb8f48ec8e702581c3a501caeed33eec3a81d7041cbc8026
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Collection of utilities for controlling TCP/IP networking"
pkg_upstream_url=https://wiki.linuxfoundation.org/networking/iproute2
pkg_license=('GPL-2.0')
pkg_bin_dirs=(sbin)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  lilian/bison
  lilian/flex
  be/gcc
  lilian/iptables
  lilian/m4
  be/make
  lilian/pkg-config
)
pkg_deps=(core/glibc)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  # http://www.linuxfromscratch.org/lfs/view/development/chapter06/iproute2.html
  sed -i /ARPD/d Makefile
  sed -i 's/arpd.8//' man/man8/Makefile
  rm doc/arpd.sgml

  sed -i 's/m_ipt.o//' tc/Makefile
}

do_build() {
  SBINDIR="$pkg_prefix/sbin"
  export SBINDIR
  do_default_build
}

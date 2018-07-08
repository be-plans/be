pkg_name=dbus
pkg_origin=core
pkg_version=1.12.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPLv2')
pkg_description="D-Bus is a message bus system, a simple way for applications to talk to one another."
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/dbus/"
pkg_source="https://dbus.freedesktop.org/releases/dbus/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=272bb5091770b047c8188b926d5e6038fa4fe6745488b2add96b23e2d9a83d88
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/autoconf
  lilian/automake
  lilian/pkg-config
  lilian/make
  lilian/gcc
  lilian/expat
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

source ../defaults.sh

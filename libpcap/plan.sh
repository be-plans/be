pkg_name=libpcap
pkg_origin=be
pkg_version=1.8.1
pkg_description="A portable C/C++ library for network traffic capture."
pkg_upstream_url="http://www.tcpdump.org/"
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.tcpdump.org/release/libpcap-${pkg_version}.tar.gz"
pkg_shasum=673dbc69fdc3f5a86fb5759ab19899039a8e5e6c631749e48dcd9c6f0c83541e
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/gcc lilian/make lilian/flex
  lilian/bison lilian/m4
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

no_pie=true
source ../defaults.sh

do_build() {
  ./configure --prefix="$pkg_prefix" --with-pcap=linux
  make -j "$(nproc)"
}

do_check() {
  make tests
}

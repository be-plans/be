pkg_name=tor
pkg_version=0.3.3.6
pkg_origin=core
pkg_license=('BSD-3-Clause')
pkg_description="Free software and an open network that helps you defend against traffic analysis"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://www.torproject.org/"
pkg_source="https://www.torproject.org/dist/tor-${pkg_version}.tar.gz"
pkg_shasum=99bc59f6dbf395894de12f3a83b3251a82dfd93dc7f6d3afcbbd80f6111433b7
pkg_deps=(
  core/glibc
  lilian/gcc-libs
  lilian/libevent
  lilian/openssl
  lilian/zlib
  lilian/libseccomp
  lilian/libscrypt
)
pkg_build_deps=(
  lilian/gcc lilian/make lilian/pkg-config
  lilian/python
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_svc_run="tor -f $pkg_svc_config_path/torrc"
pkg_exports=(
  [port]=socks_bind_port
)
pkg_exposes=(port)

source ../defaults.sh

do_build() {
   # Enabling -02 avoids hundreds of warnings about _FORTIFY_SOURCE
   export CFLAGS="-O2 ${CFLAGS}"
   # -lgcc_s seems to be needed to dlopen libgcc_s.so
   # It is unclear to me why this is needed since the RUNPATH tag in the elf binary
   # contains the path that includes libgcc_s.so
   export LDFLAGS="-lgcc_s ${LDFLAGS}"
   ./configure --prefix="${pkg_prefix}" --disable-dependency-tracking
   make -j "$(nproc)"
}

do_check() {
  make test
}

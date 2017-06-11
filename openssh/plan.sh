pkg_origin=lilian
pkg_name=openssh
pkg_version=7.5p1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Provides OpenSSH client and server."
pkg_license=('BSD')
pkg_source=http://ftp3.usa.openbsd.org/pub/OpenBSD/OpenSSH/portable/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=9846e3c5fab9f0547400b4d2c017992f914222b3fd1f8eee6c7dc6bc5e59f9f0
pkg_upstream_url=https://www.openssh.com/
pkg_bin_dirs=(bin sbin libexec)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_deps=(core/glibc lilian/openssl  lilian/zlib)
pkg_build_deps=(lilian/coreutils lilian/gcc lilian/make)

compiler_flags() {
  local -r optimizations="-O2 -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags
}

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --sysconfdir="${pkg_svc_path}/config" \
              --localstatedir="${pkg_svc_path}/var" \
              --datadir="${pkg_svc_data_path}" \
              --with-privsep-user=hab \
              --with-privsep-path="${pkg_prefix}/var/empty"
  make -j $(nproc)
}

do_install() {
  make install-nosysconf
  mkdir -p "${pkg_prefix}/var/empty"
  chmod 700 "${pkg_prefix}/var/empty"
}

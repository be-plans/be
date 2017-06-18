pkg_name=apr
pkg_origin=lilian
pkg_version=1.5.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Apache Portable Runtime"
pkg_upstream_url="https://apr.apache.org/"
pkg_license=('Apache-2.0')
pkg_source=http://www.us.apache.org/dist/apr/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=7d03ed29c22a7152be45b8e50431063736df9e1daa1ddf93f6a547ba7a28f67a
pkg_deps=(
  lilian/gcc-libs lilian/glibc lilian/grep
  lilian/sed lilian/binutils
)
pkg_build_deps=(
  lilian/diffutils lilian/file lilian/gcc
  lilian/iana-etc lilian/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  export LDFLAGS="-lgcc_s ${LDFLAGS}"

  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_default_build() {
  ./configure --prefix="${pkg_prefix:?}"
  make -j $(nproc)
}

do_check() {
  # If `/etc/services` does not exist, make temporary version from the
  # `iana-etc` package. This is needed for the testsock tests to pass.
  if [[ ! -f /etc/services ]]; then
    cp -v "$(pkg_path_for iana-etc)/etc/services" /etc/services
    local clean_services=true
  fi

  make test

  if [[ -n "$clean_services" ]]; then
    rm -fv /etc/services
  fi
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

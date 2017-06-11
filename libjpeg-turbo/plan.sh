pkg_name=libjpeg-turbo
pkg_distname=${pkg_name}
pkg_origin=lilian
pkg_version=1.5.1
pkg_description="A faster (using SIMD) libjpeg implementation";
pkg_upstream_url=http://libjpeg-turbo.virtualgl.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('IJG' 'BSD-3-Clause' 'Zlib')
pkg_source=https://sourceforge.net/projects/${pkg_distname}/files/${pkg_version}/${pkg_distname}-${pkg_version}.tar.gz/download
pkg_filename=${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=41429d3d253017433f66e3d472b8c7d998491d2f41caa7306b8d9a6f2a2c666c
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/diffutils
  lilian/file
  lilian/gcc
  lilian/make
  lilian/nasm
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

compiler_flags() {
  local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} -Wno-error "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} -Wno-error "
  export CPPFLAGS="${CPPFLAGS} -Wno-error "
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags

  # The configure script expects `file` binaries to be in `/usr/bin`
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_check() {
  make test
}

do_end() {
  # Clean up
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

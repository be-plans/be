pkg_name=libjpeg-turbo
pkg_distname=${pkg_name}
pkg_origin=lilian
pkg_version=1.5.0
pkg_description="A faster (using SIMD) libjpeg implementation";
pkg_upstream_url=http://libjpeg-turbo.virtualgl.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('IJG' 'BSD-3-Clause' 'Zlib')
pkg_source=https://sourceforge.net/projects/${pkg_distname}/files/${pkg_version}/${pkg_distname}-${pkg_version}.tar.gz/download
pkg_filename=${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=9f397c31a67d2b00ee37597da25898b03eb282ccd87b135a50a69993b6a2035f
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/diffutils
  lilian/file
  lilian/gcc
  lilian/make
  core/nasm
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_prepare() {
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

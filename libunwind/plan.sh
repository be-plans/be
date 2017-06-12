pkg_name=libunwind
pkg_origin=lilian
pkg_version=1.1
pkg_description="A C programming interface to determine the call-chain of a program."
pkg_upstream_url="http://www.nongnu.org/libunwind/"
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.savannah.gnu.org/releases/libunwind/libunwind-${pkg_version}.tar.gz"
pkg_shasum=9dfe0fcae2a866de9d3942c66995e4b460230446887dbdab302d41a8aee8d09a
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(lilian/gcc lilian/make lilian/diffutils core/file lilian/coreutils)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  _file_path="$(pkg_path_for file)/bin/file"
  sed -e "s#/usr/bin/file#${_file_path}#g" -i configure

  # /bin/ls is required for some of the tests
  if [[ ! -r /bin/ls ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/ls" /bin/ls
    _clean_ls=true
  fi
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_ls" ]]; then
    rm -fv /bin/ls
  fi
}

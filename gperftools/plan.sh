pkg_name=gperftools
pkg_origin=core
pkg_version=2.6.90
pkg_description="Google Performance Tools"
pkg_upstream_url=https://github.com/gperftools/gperftools
pkg_license=('BSDv3')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/gperftools/gperftools/releases/download/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=2f8ec5129701e6c68c75009db5303761b65b51867c63e49ec19b946930cfef1f
pkg_deps=(core/glibc lilian/gcc-libs lilian/graphviz lilian/coreutils lilian/grep lilian/perl lilian/binutils)
pkg_build_deps=(lilian/gcc lilian/make lilian/automake)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  do_default_build

  fix_interpreter "src/pprof" lilian/coreutils bin/env
  sed -e "s#\"objdump\",#\"$(pkg_path_for lilian/binutils)/bin/objdump\",#" \
      -e "s#\"nm\",#\"$(pkg_path_for lilian/binutils)/bin/nm\",#" \
      -e "s#\"addr2line\",#\"$(pkg_path_for lilian/binutils)/bin/addr2line\",#" \
      -e "s#\"c++filt\",#\"$(pkg_path_for lilian/binutils)/bin/c++filt\",#" \
      -e "s#ShellEscape(\"grep\"#ShellEscape(\"$(pkg_path_for lilian/grep)/bin/grep\"#" \
      -e "s#ShellEscape(\"tail\"#ShellEscape(\"$(pkg_path_for lilian/coreutils)/bin/tail\"#" \
      -e "s#(\"dot\")#(\"$(pkg_path_for lilian/graphviz)/bin/dot\")#" \
      -i "src/pprof"
}

do_check() {
  make check
}

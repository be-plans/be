pkg_origin=lilian
pkg_name=ant
pkg_version=1.10.1
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Apache-2.0')
pkg_source=https://github.com/apache/ant/archive/rel/$pkg_version.tar.gz
pkg_shasum=8bb3211dd7c849cfd61fb7573c8054909bddbc0f35ec5bed846cde6b132b11a6
pkg_deps=(lilian/coreutils lilian/jdk8)
pkg_build_deps=(lilian/jdk8)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  export JAVA_HOME=$(hab pkg path lilian/jdk8)
  pushd $HAB_CACHE_SRC_PATH/$pkg_name-rel-$pkg_version
  sh ./build.sh -Ddist.dir=$pkg_prefix dist
}

do_install() {
  return 0
}

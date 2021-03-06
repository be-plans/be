pkg_name=jffi
pkg_origin=core
pkg_version="1.2.16"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/jnr/jffi/archive/${pkg_name}-${pkg_version}.tar.gz"
pkg_dirname="${pkg_name}-${pkg_name}-${pkg_version}"
pkg_shasum="a116c53f26d13d738aaf6e21fe52231be5f0df6e1007673846fd18a4be875121"
pkg_upstream_url="https://github.com/jnr/jffi"
pkg_deps=(core/glibc lilian/libffi lilian/gcc-libs lilian/jre8)
pkg_build_deps=(
  lilian/jdk8
  lilian/ant
  lilian/pkg-config
  lilian/make
  lilian/gcc
  lilian/file
  lilian/diffutils
  lilian/maven
)

do_prepare() {
  build_line "replacing /usr/bin/file with $(pkg_path_for lilian/file)/bin/file"
  sed -i "s,/usr/bin/file,$(pkg_path_for lilian/file)/bin/file,g" "jni/libffi/configure"

  export USE_SYSTEM_LIBFFI=1
  export JAVA_HOME
  JAVA_HOME="$(pkg_path_for jdk8)"
}

do_build() {
  ant jar
  ant -Djava.library.path="${LD_RUN_PATH}" archive-platform-jar
  mvn -Djava.library.path="${LD_RUN_PATH}" package
}

do_install() {
  cp -r target "${pkg_prefix}"
}

# Strip was unable to recognise the format of the input file libjffi-1.2.so
do_strip() {
  return 0
}

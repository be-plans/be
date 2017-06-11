pkg_origin=lilian
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_name=jruby1
pkg_version=1.7.25
pkg_description="A high performance, stable, fully threaded Java implementation of the Ruby programming language."
pkg_upstream_url=https://github.com/jruby/jruby
pkg_source=https://github.com/jruby/jruby/archive/${pkg_version}.tar.gz
pkg_shasum=4e17872bc38cf6c0ff238a365d2046e36e3149d0d381df2198fd949902602c9c
pkg_license=('EPL 1.0' 'GPL-2.0' 'LGPL-2.1')
pkg_deps=(
  lilian/bash
  lilian/coreutils
  core/glibc
  lilian/jre8
)
pkg_build_deps=(
  lilian/jdk8
  lilian/make
  lilian/which
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=jruby-${pkg_version}

do_build() {
  export JAVA_HOME
  JAVA_HOME=$(pkg_path_for lilian/jdk8)
  ./mvnw
}

do_install() {
  cp -R ./* "$pkg_prefix/"
  fix_interpreter "$pkg_prefix/bin/*" lilian/coreutils bin/env

  # Remove *.so for other platforms...they cause `do_strip()' to fail
  # with `Unable to recognise the format' errors
  find "$pkg_prefix/lib/jni/" -maxdepth 1 -mindepth 1 -type d -not -name "x86_64-Linux" -exec rm -rf "{}" \;
}

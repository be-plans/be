pkg_name=gradle
pkg_origin=core
pkg_version=4.3.1
pkg_source=https://services.gradle.org/distributions/${pkg_name}-${pkg_version}-bin.zip
pkg_shasum=15ebe098ce0392a2d06d252bff24143cc88c4e963346582c8d88814758d93ac7
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_deps=(
  core/glibc core/gcc-libs lilian/jre8
  be/coreutils lilian/bash-static be/sed)
pkg_build_deps=(
  be/make be/gcc
  lilian/jdk8 be/patchelf
)

source ../defaults.sh

do_build() {
  mkdir patching
  pushd patching
  jar xf ../lib/native-platform-linux-amd64-0.14.jar
  patchelf --set-rpath "${LD_RUN_PATH}" net/rubygrapefruit/platform/linux-amd64/libnative-platform.so
  jar cf native-platform-linux-amd64-0.14.jar .
  mv native-platform-linux-amd64-0.14.jar ../lib/
  popd
  rm -rf patching
  fix_interpreter bin/gradle be/coreutils bin/env
}

do_install() {
  cp -vr . "$pkg_prefix"
}

do_strip() {
  return 0
}

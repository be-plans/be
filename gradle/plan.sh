pkg_name=gradle
pkg_origin=lilian
pkg_version=3.5
pkg_source=https://services.gradle.org/distributions/${pkg_name}-${pkg_version}-bin.zip
pkg_shasum=0b7450798c190ff76b9f9a3d02e18b33d94553f708ebc08ebe09bdf99111d110
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_deps=(
  core/glibc core/gcc-libs lilian/jre8
  lilian/coreutils core/bash-static lilian/sed)
pkg_build_deps=(
  lilian/make lilian/gcc
  lilian/jdk8 lilian/patchelf
)

source ../better_defaults.sh

do_build() {
  mkdir patching
  pushd patching
  jar xf ../lib/native-platform-linux-amd64-0.14.jar
  patchelf --set-rpath "${LD_RUN_PATH}" net/rubygrapefruit/platform/linux-amd64/libnative-platform.so
  jar cf native-platform-linux-amd64-0.14.jar .
  mv native-platform-linux-amd64-0.14.jar ../lib/
  popd
  rm -rf patching
  fix_interpreter bin/gradle lilian/coreutils bin/env
}

do_install() {
  cp -vr . "$pkg_prefix"
}

do_strip() {
  return 0
}

pkg_name=dotnet-core
pkg_origin=lilian
pkg_version=1.1.2
pkg_license=('MIT')
pkg_upstream_url=https://www.microsoft.com/net/core
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/${pkg_version}/dotnet-debian-x64.${pkg_version}.tar.gz"
pkg_shasum=26f6a2e247dd0b9ac4003d12cf1bd8647985255fdd7659b60e36a7a26fce15de
pkg_filename="dotnet-debian-x64.${pkg_version}.tar.gz"
pkg_deps=(
  lilian/curl
  lilian/gcc-libs
  lilian/glibc
  lilian/icu52
  core/krb5
  lilian/libunwind
  lilian/lttng-ust
  lilian/openssl 
  lilian/util-linux
  lilian/zlib
)
pkg_build_deps=(
  lilian/patchelf
)
pkg_bin_dirs=(bin)

do_unpack() {
  # Extract into $pkg_dirname instead of straight into $HAB_CACHE_SRC_PATH.
  mkdir -p "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  tar xfz "$HAB_CACHE_SRC_PATH/$pkg_filename" -C "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_prepare() {
  find -type f -name 'dotnet' \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "$LD_RUN_PATH" {} \;
  find -type f -name '*.so*' \
    -exec patchelf --set-rpath "$LD_RUN_PATH" {} \;
}

do_build() {
  return 0
}

do_install() {
  cp -a . "$pkg_prefix/bin"
  chmod o+r -R "$pkg_prefix/bin"
}

do_strip() {
  return 0
}

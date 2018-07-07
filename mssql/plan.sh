pkg_name=mssql
pkg_origin=core
pkg_version=14.0.3025.34-3
pkg_license=('MICROSOFT PRE-RELEASE SOFTWARE LICENSE')
pkg_upstream_url=https://www.microsoft.com/en-us/sql-server/sql-server-vnext-including-Linux
pkg_description="Microsoft SQL Server for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_${pkg_version}_amd64.deb"
pkg_shasum=359d436c4a40112ab1ce2e2f1e3ef1d4136fa9ffe26eeb7ac18e49d5be6eaee3
pkg_filename="mssql-server_${pkg_version}_amd64.deb"
pkg_svc_user="root"
pkg_svc_group="root"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

pkg_deps=(
  core/libcxx
  core/libcxxabi
  be/gcc-libs
  core/glibc
  lilian/jemalloc
  be/krb5
  be/numactl
  be/openssl
  be/python2
  be/util-linux
)

pkg_build_deps=(
  lilian/dpkg
  be/patchelf
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_unpack() {
  dpkg -x "$HAB_CACHE_SRC_PATH/$pkg_filename" "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_build() {
  return 0
}

do_install() {
  cp -a opt/mssql/bin "$pkg_prefix"
  cp -a opt/mssql/lib "$pkg_prefix"

  PYTHONPATH="$(pkg_path_for lilian/python2)"
  sed -i "s#/usr/bin/python#$PYTHONPATH/bin/python#" "$pkg_prefix/lib/mssql-conf/mssql-conf.py"

  find "$pkg_prefix/bin" -type f -name '*' \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "$LD_RUN_PATH" {} \;
  find "$pkg_prefix/lib" -type f -name '*.so*' \
    -exec patchelf --set-rpath "$LD_RUN_PATH" {} \;
}

do_strip() {
  return 0
}

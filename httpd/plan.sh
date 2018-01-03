pkg_name=httpd
pkg_origin=core
pkg_version=2.4.25
pkg_description="The Apache HTTP Server"
pkg_upstream_url="http://httpd.apache.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://archive.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=f87ec2df1c9fee3e6bfde3c8b855a3ddb7ca1ab20ca877bd0e2b6bf3f05c80b2
pkg_deps=(
  core/glibc lilian/expat lilian/libiconv
  lilian/apr lilian/apr-util lilian/pcre
  lilian/zlib be/openssl  core/gcc-libs
)
pkg_build_deps=(be/patch be/make be/gcc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_exports=(
  [port]=serverport
)
pkg_exposes=(port)
pkg_svc_run="httpd -DFOREGROUND -f $pkg_svc_config_path/httpd.conf"
pkg_svc_user="root"
pkg_svc_group="root"

source ../defaults.sh

do_build() {
    ./configure --prefix="$pkg_prefix" \
                --with-expat="$(pkg_path_for lilian/expat)" \
                --with-iconv="$(pkg_path_for lilian/libiconv)" \
                --with-pcre="$(pkg_path_for lilian/pcre)" \
                --with-apr="$(pkg_path_for lilian/apr)" \
                --with-apr-util="$(pkg_path_for lilian/apr-util)" \
                --with-z="$(pkg_path_for lilian/zlib)" \
                --with-ssl="$(pkg_path_for be/openssl )" \
                --enable-modules="none" \
                --enable-mods-static="none" \
                --enable-mods-shared="reallyall" \
                --enable-mpms-shared="prefork event worker"
    make -j $(nproc)
}

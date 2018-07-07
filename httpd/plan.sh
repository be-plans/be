pkg_name=httpd
pkg_origin=core
pkg_version=2.4.25
pkg_description="The Apache HTTP Server"
pkg_upstream_url="http://httpd.apache.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://archive.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=346dd3d016ae5d7101016e68805150bdce9040a8d246c289aa70e68a7cd86b66
pkg_deps=(lilian/apr lilian/apr-util be/bash be/expat be/gcc-libs core/glibc be/libiconv be/openssl be/pcre be/perl be/zlib)
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
                --with-expat="$(pkg_path_for be/expat)" \
                --with-iconv="$(pkg_path_for be/libiconv)" \
                --with-pcre="$(pkg_path_for be/pcre)" \
                --with-apr="$(pkg_path_for lilian/apr)" \
                --with-apr-util="$(pkg_path_for lilian/apr-util)" \
                --with-z="$(pkg_path_for be/zlib)" \
                --with-ssl="$(pkg_path_for be/openssl )" \
                --enable-modules="none" \
                --enable-mods-static="none" \
                --enable-mods-shared="reallyall" \
                --enable-mpms-shared="prefork event worker"
    make -j $(nproc)
}

pkg_name=nginx
pkg_origin=core
pkg_version=1.13.1
pkg_description="NGINX web server."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('bsd')
pkg_source=https://nginx.org/download/nginx-${pkg_version}.tar.gz
pkg_upstream_url=https://nginx.org/
pkg_shasum=a5856c72a6609a4dc68c88a7f3c33b79e6693343b62952e021e043fe347b6776
pkg_deps=(
  core/glibc lilian/libedit be/ncurses
  be/zlib be/bzip2 be/openssl
  be/pcre
)
pkg_build_deps=(be/gcc be/make be/coreutils)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(sbin)
pkg_include_dirs=(include)
pkg_svc_run="nginx"
pkg_svc_user="root"
pkg_exports=(
  [port]=http.listen.port
)
pkg_exposes=(port)

source ../defaults.sh

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --conf-path="$pkg_svc_config_path/nginx.conf" \
    --sbin-path="$pkg_prefix/bin/nginx" \
    --pid-path="$pkg_svc_var_path/nginx.pid" \
    --lock-path="$pkg_svc_var_path/nginx.lock" \
    --user=hab \
    --group=hab \
    --http-log-path=/dev/stdout \
    --error-log-path=stderr \
    --http-client-body-temp-path="$pkg_svc_var_path/client-body" \
    --http-proxy-temp-path="$pkg_svc_var_path/proxy" \
    --http-fastcgi-temp-path="$pkg_svc_var_path/fastcgi" \
    --http-scgi-temp-path="$pkg_svc_var_path/scgi" \
    --http-uwsgi-temp-path="$pkg_svc_var_path/uwsgi" \
    --with-ipv6 \
    --with-pcre \
    --with-pcre-jit \
    --with-file-aio \
    --with-stream=dynamic \
    --with-mail=dynamic \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_v2_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_addition_module \
    --with-http_degradation_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_secure_link_module \
    --with-http_sub_module \
    --with-http_slice_module \
    --with-cc-opt="$CFLAGS" \
    --with-ld-opt="$LDFLAGS"

  make -j "$(nproc)"
}

do_install() {
  make -j "$(nproc)" install
  mkdir -p "$pkg_prefix/sbin"
  cp "$HAB_CACHE_SRC_PATH/$pkg_dirname/objs/nginx" "$pkg_prefix/sbin"
}

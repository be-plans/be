# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

pkg_name=wordpress
pkg_origin=lilian
pkg_version="4.7.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://wordpress.org/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="c11ce7580f21dfbca70dd6f817d3376385be6d34cf4d86f233eae3acb5fd87fd"
pkg_description="installs wordpress"
pkg_upstream_url="https://wordpress.org/"

source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

pkg_deps=(lilian/php lilian/curl core/wordpress-proxy/4.7.4 core/mysql-client)

pkg_exports=()
pkg_exposes=()

pkg_binds=(
  [database]="port username password"
)


do_build(){
  return 0
}

do_install() {
  cp -r "$source_dir" "$pkg_prefix/public_html/"
}

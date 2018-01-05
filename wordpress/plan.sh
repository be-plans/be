# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

pkg_name=wordpress
pkg_origin=core
pkg_version=4.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://wordpress.org/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="39210d593700dc26c58a53b38172be63ea3da67020d80bb2cf34b396b732dd4d"
pkg_description="installs wordpress"
pkg_upstream_url="https://wordpress.org/"

source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

pkg_deps=(lilian/php be/curl lilian/wordpress-proxy/4.8 lilian/mysql-client)

pkg_exports=()
pkg_exposes=()

pkg_binds=(
  [database]="port username password"
)

source ../defaults.sh

do_build(){
  return 0
}

do_install() {
  cp -r "$source_dir" "$pkg_prefix/public_html/"
}

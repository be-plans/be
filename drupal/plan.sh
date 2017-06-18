pkg_name=drupal
pkg_origin=lilian
pkg_version=8.3.3
pkg_license=('GPL-2.0')
pkg_deps=(lilian/mysql-client lilian/drush lilian/nginx lilian/php)
pkg_binds=(
  [database]="port username password"
)
pkg_svc_user="root"
pkg_svc_run="php-fpm --nodaemonize"
pkg_description="Drupal is a free and open source content-management framework written in PHP."
pkg_upstream_url="https://www.drupal.org"
pkg_maintainers="The Habitat Maintainers <humans@habitat.sh>"

source ../defaults.sh

do_build() {
  drush dl drupal-${pkg_version} --destination="$CACHE_PATH" --drupal-project-rename=drupal
}

do_install() {
  cp -r "$CACHE_PATH/drupal" "$pkg_prefix/drupal"
}

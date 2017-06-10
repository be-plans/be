pkg_name=drush
pkg_origin=lilian
pkg_version="8"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2+')
pkg_deps=(core/bash lilian/coreutils core/php core/which)
pkg_build_deps=(core/composer)
pkg_bin_dirs=(bin/vendor/bin)
pkg_upstream_url="http://www.drush.org/en/master/"
pkg_description="Drush is a command line shell and Unix scripting interface for Drupal."

do_download() {
    return 0
}

do_verify() {
    return 0
}

do_unpack() {
    return 0
}

do_build() {
    composer global require drush/drush:8.*
}

do_install() {
    cp -r "$HOME/.composer/"* "$pkg_prefix/bin/"
    fix_interpreter "$pkg_prefix/bin/vendor/bin/drush" lilian/coreutils bin/env
    fix_interpreter "$pkg_prefix/bin/vendor/bin/drush.launcher" lilian/coreutils bin/env
    fix_interpreter "$pkg_prefix/bin/vendor/bin/drush.php" lilian/coreutils bin/env
}

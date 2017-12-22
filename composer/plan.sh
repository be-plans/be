pkg_name=composer
pkg_origin=lilian
pkg_version=1.4.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url=https://getcomposer.org/
pkg_description="Dependency Manager for PHP"
pkg_source=https://getcomposer.org/download/${pkg_version}/${pkg_name}.phar
pkg_filename=${pkg_name}.phar
pkg_shasum=6b1945c3ee477f12be508a5bb41a5025d57de5510bcf94855ae6a4d59f3d86f4
pkg_deps=(lilian/php lilian/git)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_unpack(){
  return 0
}

do_build() {
  return 0
}

do_check() {
  "$(pkg_path_for lilian/php)"/bin/php "../${pkg_filename}" --version 2>&1 | grep -q ${pkg_version}
}

do_install() {
  install -vDm755 "../${pkg_filename}" "${pkg_prefix}/bin/${pkg_filename}"

  cat<<EOF > "${pkg_prefix}/bin/composer"
#!/bin/sh
$(pkg_path_for lilian/php)/bin/php "$pkg_prefix/bin/$pkg_filename" "\$@"
EOF
  chmod +x "${pkg_prefix}/bin/composer"
}

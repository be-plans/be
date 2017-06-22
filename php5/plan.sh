pkg_name=php5
pkg_distname=php
pkg_origin=lilian
pkg_version=5.6.30
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('PHP-3.01')
pkg_upstream_url=http://php.net/
pkg_description="PHP is a popular general-purpose scripting language that is especially suited to web development."
pkg_source=https://php.net/get/${pkg_distname}-${pkg_version}.tar.xz/from/this/mirror
pkg_filename=${pkg_distname}-${pkg_version}.tar.xz
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_shasum=a363185c786432f75e3c7ff956b49c3369c3f6906a6b10459f8d1ddc22f70805
pkg_deps=(
  lilian/coreutils
  lilian/curl
  lilian/glibc
  lilian/libxml2
  lilian/libjpeg-turbo
  lilian/libpng
  lilian/openssl
  lilian/zlib
)
pkg_build_deps=(
  lilian/bison2
  lilian/gcc
  lilian/make
  lilian/re2c
  lilian/readline
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_interpreters=(bin/php)

source ../defaults.sh

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --enable-exif \
    --enable-fpm \
    --enable-mbstring \
    --enable-opcache \
    --with-fpm-user=hab \
    --with-fpm-group=hab \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-jpeg-dir="$(pkg_path_for libjpeg-turbo)" \
    --with-readline="$(pkg_path_for readline)" \
    --with-curl="$(pkg_path_for curl)" \
    --with-libxml-dir="$(pkg_path_for libxml2)" \
    --with-openssl="$(pkg_path_for openssl)" \
    --with-zlib="$(pkg_path_for zlib)" \
    --with-xmlrpc \
    --with-gd
  make -j "$(nproc)"
}

do_install() {
  do_default_install

  # Modify PHP-FPM config so it will be able to run out of the box. To run a real
  # PHP-FPM application you would want to supply your own config with
  # --fpm-config <file>.
  mv "$pkg_prefix/etc/php-fpm.conf.default" "$pkg_prefix/etc/php-fpm.conf"
  # Run as the hab user by default, as it's more likely to exist than nobody.
  sed -i "s/nobody/hab/g" "$pkg_prefix/etc/php-fpm.conf"
}

do_check() {
  make test
}

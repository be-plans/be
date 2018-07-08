pkg_name=sensu
pkg_origin=core
pkg_version=0.29.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A monitoring framework that aims to be simple, malleable, and scalable."
pkg_license=('MIT')
pkg_upstream_url=https://sensuapp.org
pkg_build_deps=(lilian/make lilian/gcc lilian/gcc-libs)
pkg_deps=(lilian/ruby lilian/bundler lilian/coreutils)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_svc_user=root
pkg_svc_group=${pkg_svc_user}
pkg_binds=(
  [rabbitmq]="port"
  [redis]="port"
)

source ../defaults.sh

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  mkdir -p "/hab/cache/src/${pkg_name}-${pkg_version}"
  cp -f ./Gemfile "/hab/cache/src/${pkg_name}-${pkg_version}/Gemfile"
}

do_install() {
  cp -R . "$pkg_prefix/"
  fix_interpreter "$pkg_prefix/bin/*" lilian/coreutils bin/env
}


do_build() {
  local _bundler_dir
  _bundler_dir=$(pkg_path_for bundler)

  export GEM_HOME=${pkg_path}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}
  bundle install --jobs 2 --retry 5 --path ./vendor/bundle --binstubs
}

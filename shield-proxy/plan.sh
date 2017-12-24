pkg_name=shield-proxy
pkg_origin=be
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Proxy package for the Shield backup and restore tool"
pkg_license=('Apache-2.0')
pkg_version=0.10.8
pkg_source=nosuchfile.tar.xz

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

pkg_deps=(core/nginx core/openssl core/bash)

do_build() {
  return 0
}

do_download() {
  return 0
}

do_install() {
  return 0
}

do_unpack() {
  return 0
}

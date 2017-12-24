pkg_name=kubernetes-proxy
pkg_origin=be
pkg_description="Production-Grade Container Scheduling and Management"
pkg_upstream_url=https://github.com/kubernetes/kubernetes
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=0.1.0
pkg_deps=("core/kubernetes")
pkg_svc_user="root"
pkg_svc_group="${pkg_svc_user}"

do_build() {
  return 0
}

do_install() {
  return 0
}

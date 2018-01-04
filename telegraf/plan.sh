pkg_name=telegraf
pkg_origin=core
pkg_version="1.3.5"
pkg_license=('MIT')
pkg_description="telegraf - client for InfluxDB"
pkg_upstream_url="https://github.com/influxdata/telegraf/"
pkg_source="https://dl.influxdata.com/${pkg_name}/releases/${pkg_name}-${pkg_version}-static_linux_amd64.tar.gz"
pkg_shasum="3c44bf10fc689e723c6f62f28babd8317331af507d1178100cdb16ee15b5a490"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_svc_run="telegraf --config $pkg_svc_config_path/telegraf.conf"
pkg_build_deps=(be/wget core/tar)
pkg_deps=()
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  install -vD "${HAB_CACHE_SRC_PATH}/telegraf/telegraf" "${pkg_prefix}/bin/telegraf"
}

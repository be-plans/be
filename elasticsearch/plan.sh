pkg_name=elasticsearch
pkg_origin=lilian
pkg_version=5.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open Source, Distributed, RESTful Search Engine"
pkg_upstream_url="https://elastic.co"
pkg_license=('Revised BSD')
pkg_source=https://artifacts.elastic.co/downloads/elasticsearch/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=09d6422bd33b82f065760cd49a31f2fec504f2a5255e497c81050fd3dceec485
pkg_deps=(
  core/busybox-static
  lilian/glibc
  lilian/jre8
)
pkg_bin_dirs=(es/bin)
pkg_lib_dirs=(es/lib)
pkg_exports=(
  [http-port]=network.port
  [transport-port]=transport.port
)
pkg_exposes=(http-port transport-port)

source ../defaults.sh

do_build() {
  return 0
}

do_install() {
  install -vDm644 README.textile "$pkg_prefix/README.textile"
  install -vDm644 LICENSE.txt "$pkg_prefix/LICENSE.txt"
  install -vDm644 NOTICE.txt "$pkg_prefix/NOTICE.txt"

  # Elasticsearch is greedy when grabbing config files from /bin/..
  # so we need to put the untemplated config dir out of reach
  mkdir -p "$pkg_prefix/es"
  cp -a bin lib modules "$pkg_prefix/es"
  rm "$pkg_prefix/es/bin/"*.bat "$pkg_prefix/es/bin/"*.exe
}

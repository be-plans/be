pkg_name=rabbitmq
pkg_distname=${pkg_name}-server
pkg_origin=be
pkg_version=3.6.12
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL')
pkg_description="Open source multi-protocol messaging broker"
pkg_upstream_url="https://www.rabbitmq.com"
pkg_source=http://www.rabbitmq.com/releases/rabbitmq-server/v${pkg_version}/rabbitmq-server-${pkg_version}.tar.xz
pkg_shasum=c8e5a8ed5aae6167aa0050f41bd9f26d50eb16efd8abd1a1b0b01fcbccb458b9
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(
  lilian/coreutils
  core/glibc
  lilian/erlang
)
pkg_build_deps=(
  lilian/bash
  lilian/diffutils
  lilian/gawk
  be/gcc
  lilian/git
  lilian/grep
  lilian/libxml2
  lilian/libxslt
  lilian/make
  lilian/perl
  lilian/python2
  lilian/rsync
  lilian/unzip
  lilian/zip
)
pkg_include_dirs=(include)
pkg_bin_dirs=(sbin)
pkg_exports=(
  [port]=rabbitmq.listen_port
)

pkg_exposes=(port)

source ../defaults.sh

do_prepare() {
  export PREFIX="${pkg_prefix}"
  build_line "Setting PREFIX=$PREFIX"
  export DESTDIR="${PREFIX}"
  build_line "Setting DESTDIR=$DESTDIR"
  export RMQ_ROOTDIR=""
  build_line "Setting RMQ_ROOTDIR=$RMQ_ROOTDIR"
  export RMQ_LIBDIR=""
  build_line "Setting RMQ_LIBDIR=$RMQ_LIBDIR"
  export RMQ_ERLAPP_DIR=""
  build_line "Setting RMQ_ERLAPP_DIR=$RMQ_ERLAPP_DIR"
}

do_build() {
  make -j "$(nproc)"
}

do_check() {
  make tests
}

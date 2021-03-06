pkg_name=rabbitmq
pkg_distname="${pkg_name}-server"
pkg_origin=core
pkg_version=3.7.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL')
pkg_description="Open source multi-protocol messaging broker"
pkg_upstream_url="https://www.rabbitmq.com"
pkg_source="https://github.com/rabbitmq/rabbitmq-server/releases/download/v${pkg_version}/rabbitmq-server-${pkg_version}.tar.xz"
pkg_shasum=acfa2960c45262e96747be2ade4f19e4f0280b1a760012583cad91b8393b7872
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_deps=(
  lilian/coreutils
  core/glibc
  lilian/erlang
)
pkg_build_deps=(
  lilian/bash
  lilian/diffutils
  lilian/gawk
  lilian/gcc
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
  lilian/elixir
)
pkg_include_dirs=(include)
pkg_bin_dirs=(sbin)
pkg_exports=(
  [port]=listeners.tcp.default
)
pkg_exposes=(port)

source ../defaults.sh

do_prepare() {
  export PREFIX="${pkg_prefix}"
  build_line "Setting PREFIX=${PREFIX}"
  export DESTDIR="${PREFIX}"
  build_line "Setting DESTDIR=${DESTDIR}"
  export RMQ_ROOTDIR=""
  build_line "Setting RMQ_ROOTDIR=${RMQ_ROOTDIR}"
  export RMQ_LIBDIR=""
  build_line "Setting RMQ_LIBDIR=${RMQ_LIBDIR}"
  export RMQ_ERLAPP_DIR=""
  build_line "Setting RMQ_ERLAPP_DIR=${RMQ_ERLAPP_DIR}"
  export LANG="en_US.utf8"
  export LANGUAGE="en_US:"
  export LC_ALL=en_US.UTF-8
  build_line "Setting locale to en_US.utf8"
}

do_build() {
  make -j "$(nproc)"
}

do_check() {
  make tests
}

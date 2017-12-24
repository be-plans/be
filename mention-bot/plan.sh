pkg_name=mention-bot
pkg_origin=be
pkg_version=3.0.2
pkg_description="Automatically mention potential reviewers on pull requests."
pkg_upstream_url=https://github.com/facebook/mention-bot
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source=https://github.com/facebook/mention-bot/archive/6a7a5bdda2a533bbb243cfb41454c9cb1f678b00.tar.gz
pkg_shasum=41eb19938acb626f6acd623497b6b9e2c8c8808b754db6e67be41bc0a3076245
pkg_dirname=mention-bot-6a7a5bdda2a533bbb243cfb41454c9cb1f678b00
pkg_deps=(
  lilian/elfutils
  lilian/node
)
pkg_build_deps=(
  core/glibc
  lilian/node
  lilian/patchelf
  lilian/patch
)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

source ../defaults.sh

do_prepare() {
  npm config set spin=false
  patch -p1 -i "${PLAN_CONTEXT:?}/0001-Update-dependencies.patch"
}

do_build() {
  return 0
}

do_install() {
  cp -a . "$pkg_prefix"
  cd "$pkg_prefix" || exit

  # The Flow program is shipped as a binary that hard-codes the links to GLIBC.
  # It needs to be patched so the install will work.
  npm install flow-bin
  # patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
  #   --set-rpath "$LD_RUN_PATH" \
  #   ./node_modules/flow-bin/vendor/flow

  npm install
  npm shrinkwrap
}

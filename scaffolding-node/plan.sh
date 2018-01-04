pkg_name=scaffolding-node
pkg_origin=core
pkg_version="0.6.11"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="Habitat Plan Scaffolding for Node.js Applications"
pkg_upstream_url="https://github.com/be-plans/be/tree/master/scaffolding-node"
pkg_deps=(be/tar be/rq lilian/jq-static be/gawk lilian/curl be/bc be/coreutils)
pkg_build_deps=(lilian/node be/coreutils lilian/yarn)

do_build() {
  return 0
}

do_install() {
  find lib -type f | while read -r f; do
    install -D -m 0644 "$f" "$pkg_prefix/$f"
  done
}

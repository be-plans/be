pkg_name=node
pkg_origin=core
pkg_version=8.9.1
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_upstream_url=https://nodejs.org/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz
pkg_shasum=32491b7fcc4696b2cdead45c47e52ad16bbed8f78885d32e873952fee0f971e1
pkg_deps=(core/glibc be/gcc-libs)
pkg_build_deps=(lilian/python2 be/gcc be/grep be/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_interpreters=(bin/node)
pkg_lib_dirs=(lib)

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname=node-v$pkg_version

source ../defaults.sh
do_prepare() {
  do_default_prepare
  # ./configure has a shebang of #!/usr/bin/env python2. Fix it.
  sed -e "s#/usr/bin/env python#$(pkg_path_for python2)/bin/python2#" -i configure
}

do_build() {
  ./configure \
    --prefix "${pkg_prefix}" \
    --dest-cpu "x64" \
    --dest-os "linux"

  make -j"$(nproc)"
}

do_install() {
  do_default_install

  # Node produces a lot of scripts that hardcode `/usr/bin/env`, so we need to
  # fix that everywhere to point directly at the env binary in be/coreutils.
  grep -nrlI '^\#\!/usr/bin/env' "$pkg_prefix" | while read -r target; do
    sed -e "s#\#\!/usr/bin/env node#\#\!${pkg_prefix}/bin/node#" -i "$target"
  done
}

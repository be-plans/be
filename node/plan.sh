pkg_name=node
pkg_origin=lilian
pkg_version=8.1.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_upstream_url=https://nodejs.org/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.xz
pkg_shasum=f2ff20b69b782dee85e887ad06e830590b2250856f6df325ed15a368bb6777fc
pkg_deps=(
  core/glibc core/gcc-libs lilian/coreutils
)
pkg_build_deps=(
  lilian/python2 lilian/gcc lilian/grep
  lilian/make
)
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
  fix_interpreter configure lilian/coreutils bin/env
}

do_install() {
  do_default_install

  # Node produces a lot of scripts that hardcode `/usr/bin/env`, so we need to
  # fix that everywhere to point directly at the env binary in lilian/coreutils.
  grep -l -R ^\#\!/usr/bin/env "$pkg_prefix" | while IFS= read -r f; do
    fix_interpreter "$(readlink -f "$f")" lilian/coreutils bin/env
  done
}

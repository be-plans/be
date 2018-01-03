pkg_name=virtualenv
pkg_origin=core
pkg_version=15.1.0
pkg_description="virtualenv is a tool to create isolated Python environments. This version is for python2. For python3 use the built-in 'pyvenv'"
pkg_upstream_url=https://virtualenv.pypa.io/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source=https://pypi.io/packages/source/v/$pkg_name/$pkg_name-$pkg_version.tar.gz
pkg_shasum=02f8102c2436bb03b3ee6dede1919d1dac8a427541652e5ec95171ec8adbc93a
pkg_deps=(
  lilian/python2
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  return 0
}

do_install() {
  export PYTHONPATH="$pkg_prefix/lib/python2.7/site-packages/"
  mkdir -p "$PYTHONPATH"
  python setup.py install --prefix="$pkg_prefix"

  # Modify the command to have the correct PYTHONPATH
  sed -i "2iimport sys; sys.path.append(\"$PYTHONPATH\")" "$pkg_prefix/bin/virtualenv"
}

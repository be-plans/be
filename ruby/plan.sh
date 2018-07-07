pkg_name=ruby
pkg_origin=core
pkg_version=2.5.1
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=dac81822325b79c3ba9532b048c2123357d3310b2b40024202f360251d9829b1
pkg_deps=(
  core/glibc be/ncurses be/zlib
  be/openssl lilian/libyaml be/libffi
  be/readline
)
pkg_build_deps=(
  be/coreutils be/diffutils be/patch
  be/make be/gcc be/sed
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/ruby)

pkg_disabled_features=(pic)
source ../defaults.sh

do_prepare() {
  do_default_prepare
  export CFLAGS="${CFLAGS} -O3 -pipe"
  build_line "Setting CFLAGS='$CFLAGS'"
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --enable-shared \
    --disable-install-doc \
    --with-openssl-dir="$(pkg_path_for be/openssl )" \
    --with-libyaml-dir="$(pkg_path_for lilian/libyaml)"

  make -j $(nproc)
}

do_check() {
  make test
}

do_install() {
  do_default_install
  gem update --system --no-document
  gem install rb-readline --no-document
}

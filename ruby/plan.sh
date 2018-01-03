pkg_name=ruby
pkg_origin=core
pkg_version=2.4.2
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=93b9e75e00b262bc4def6b26b7ae8717efc252c47154abb7392e54357e6c8c9c
pkg_deps=(
  core/glibc lilian/ncurses lilian/zlib
  be/openssl lilian/libyaml lilian/libffi
  lilian/readline
)
pkg_build_deps=(
  be/coreutils be/diffutils be/patch
  be/make be/gcc be/sed
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/ruby)

no_pie=true
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

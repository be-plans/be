pkg_name=ruby
pkg_origin=lilian
pkg_version=2.4.1
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=4fc8a9992de3e90191de369270ea4b6c1b171b7941743614cc50822ddc1fe654
pkg_deps=(
  core/glibc lilian/ncurses lilian/zlib
  lilian/openssl lilian/libyaml lilian/libffi
  lilian/readline
)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/sed
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/ruby)

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
    --with-openssl-dir="$(pkg_path_for lilian/openssl )" \
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

# shellcheck disable=SC2148,SC1091
source ../ruby/plan.sh

pkg_name=ruby22
pkg_origin=core
pkg_version=2.2.10
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/ruby/ruby-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=cd51019eb9d9c786d6cb178c37f6812d8a41d6914a1edaf0050c051c75d7c358
pkg_dirname="ruby-$pkg_version"
pkg_deps=(core/glibc/2.22 lilian/ncurses/6.0 lilian/zlib/1.2.8 lilian/openssl/1.0.2l lilian/libyaml/0.1.6/20170514013335 lilian/libffi/3.2.1/20170514003538 lilian/readline/6.3.8)
pkg_build_deps=(lilian/coreutils lilian/diffutils lilian/patch lilian/make lilian/gcc/5.2.0 lilian/sed)

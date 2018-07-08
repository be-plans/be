pkg_name=tmux
pkg_origin=core
pkg_version=2.7
pkg_description="A terminal multiplexer"
pkg_upstream_url=https://tmux.github.io/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/tmux/tmux/releases/download/${pkg_version}/tmux-${pkg_version}.tar.gz"
pkg_shasum=9ded7d100313f6bc5a87404a4048b3745d61f2332f99ec1400a7c4ed9485d452
pkg_deps=(core/glibc lilian/libevent lilian/ncurses)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)

source ../defaults.sh

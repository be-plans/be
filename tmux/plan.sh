pkg_name=tmux
pkg_origin=lilian
pkg_version=2.5
pkg_description="A terminal multiplexer"
pkg_upstream_url=https://tmux.github.io/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/tmux/tmux/releases/download/${pkg_version}/tmux-${pkg_version}.tar.gz"
pkg_shasum=ae135ec37c1bf6b7750a84e3a35e93d91033a806943e034521c8af51b12d95df
pkg_deps=(lilian/glibc lilian/libevent lilian/ncurses)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)

source ../defaults.sh

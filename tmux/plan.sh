pkg_name=tmux
pkg_origin=be
pkg_version=2.6
pkg_description="A terminal multiplexer"
pkg_upstream_url=https://tmux.github.io/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/tmux/tmux/releases/download/${pkg_version}/tmux-${pkg_version}.tar.gz"
pkg_shasum=b17cd170a94d7b58c0698752e1f4f263ab6dc47425230df7e53a6435cc7cd7e8
pkg_deps=(core/glibc lilian/libevent lilian/ncurses)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)

source ../defaults.sh

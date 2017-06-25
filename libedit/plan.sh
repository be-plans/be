pkg_name=libedit
pkg_origin=lilian
pkg_version=3.1.20170329
pkg_license=('BSD')
pkg_source=http://thrysoee.dk/editline/libedit-20170329-3.1.tar.gz
pkg_dirname=${pkg_name}-20170329-3.1
pkg_shasum=91f2d90fbd2a048ff6dad7131d9a39e690fd8a8fd982a353f1333dd4017dd4be
pkg_deps=(core/glibc lilian/ncurses)
pkg_build_deps=(lilian/gcc lilian/make lilian/coreutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source ../defaults.sh


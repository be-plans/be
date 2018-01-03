pkg_origin=core
pkg_name=memcached
pkg_version=1.4.37
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Distributed memory object caching system"
pkg_upstream_url="https://memcached.org/"
pkg_license=('BSD')
pkg_source=http://www.memcached.org/files/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=2f335ab9110ce39036c5271ef39a582a852e424bc9659e421844073cfdf8606b
pkg_deps=(core/glibc lilian/libevent)
pkg_build_deps=(lilian/git be/gcc be/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_svc_run="memcached"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

be_optimizations="-O2 -fomit-frame-pointer -fno-asynchronous-unwind-tables -ftree-vectorize -m64 -mavx -march=x86-64 -mtune=corei7-avx"
source ../defaults.sh

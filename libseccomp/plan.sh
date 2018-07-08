pkg_name=libseccomp
pkg_version=2.3.2
pkg_origin=core
pkg_license=('LGPL-2.1')
pkg_description="An easy to use, platform independent, interface
to the Linux Kernel's syscall filtering mechanism."
pkg_upstream_url="https://github.com/seccomp/libseccomp"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/seccomp/libseccomp/releases/download/v${pkg_version}/libseccomp-${pkg_version}.tar.gz"
pkg_shasum=3ddc8c037956c0a5ac19664ece4194743f59e1ccd4adde848f4f0dae7f77bca1
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/gcc lilian/make lilian/diffutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

source ../defaults.sh

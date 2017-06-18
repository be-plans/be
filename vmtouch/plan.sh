pkg_origin=lilian
pkg_name=vmtouch
pkg_version=1.3.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_description="vmtouch is a tool for learning about and controlling the file system cache of unix and unix-like systems"
pkg_upstream_url=https://hoytech.com/vmtouch/
pkg_source="https://github.com/hoytech/vmtouch/archive/v${pkg_version}.tar.gz"
pkg_shasum=4615980b8f824c8eb164e50ec0880bcb71591f4e3989a6075e5a3e2efd122ceb
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/gcc lilian/make lilian/perl)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build () {
  make PREFIX="${pkg_prefix}"
}

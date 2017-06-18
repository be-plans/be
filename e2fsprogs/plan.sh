pkg_name=e2fsprogs
pkg_origin=lilian
pkg_version="1.43.4"
pkg_source="https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/snapshot/e2fsprogs-${pkg_version}.tar.gz"
pkg_shasum="206d27b4ea64fdee562d10a3d08ce213d2b2b76be69d65a9e7da6de4c67c28e5"
pkg_deps=(lilian/glibc)
pkg_build_deps=(lilian/make lilian/gcc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin sbin)

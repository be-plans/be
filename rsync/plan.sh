pkg_name=rsync
pkg_version=3.1.2
pkg_origin=lilian
pkg_license=('GPL-3.0')
pkg_description="An open source utility that provides fast incremental file transfer"
pkg_upstream_url="https://rsync.samba.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://download.samba.org/pub/${pkg_name}/src/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ecfa62a7fa3c4c18b9eccd8c16eaddee4bd308a76ea50b5c02a5840f09c0a1c2
pkg_deps=(core/glibc lilian/perl lilian/acl lilian/attr)
pkg_build_deps=(lilian/make lilian/gcc lilian/perl lilian/diffutils)
pkg_bin_dirs=(bin)

source ../defaults.sh

#
# The tests may fail inside the studio depending on where your studio
# is hosted as some of the tests (default-acl, hardlinks, xattrs,
# xattrs-hlink) make assumptions about the capabilities of the
# underlying filesystem.
#
# In a boot2docker based studio expect default-acl and hardlinks to
# fail because of the limitations of aufs.
#
# On a machine with selinux, xattrs and xattrs-hlinks may fail because
# of the selinux context information in the extended attributes.
#
do_check() {
  make check
}

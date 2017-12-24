pkg_name=rngd
pkg_description="Check and feed random data from hardware device to kernel"
pkg_origin=be
pkg_version=5
pkg_license=('GPL-2.0')
pkg_upstream_url=https://sourceforge.net/projects/gkernel/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://downloads.sourceforge.net/sourceforge/gkernel/rng-tools-${pkg_version}.tar.gz
pkg_shasum=60a102b6603bbcce2da341470cad42eeaa9564a16b4490e7867026ca11a3078e
pkg_bin_dirs=(bin sbin)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_deps=(core/glibc)
pkg_dirname=rng-tools-5
pkg_svc_run="rngd -f -r /dev/urandom"
pkg_svc_user=root
pkg_svc_group=root

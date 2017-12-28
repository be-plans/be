pkg_name=sysstat
pkg_origin=be
pkg_version=11.5.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Sysstat and the utilities it provides: iostat, mpstat, pidstat, sar, sa1, sa2 and sadf"
pkg_upstream_url="http://sebastien.godard.pagesperso-orange.fr/"
pkg_license=('GPL-2.0')
pkg_source=http://pagesperso-orange.fr/sebastien.godard/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=285f5a2fc63a40655940bf56a5a28f0ff271d817cd0cdc5e5b56af30efb9c426
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/make be/gcc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

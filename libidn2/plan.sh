pkg_origin=core
pkg_name=libidn2
pkg_version=2.0.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPLv2.1+')
pkg_description="Libidn2 is an implementation of the IDNA2008 + TR46 "\
"specifications (RFC 5890, RFC 5891, RFC 5892, RFC 5893, TR 46)"
pkg_upstream_url=https://www.gnu.org/software/libidn/#libidn2
pkg_source=https://ftp.gnu.org/gnu/libidn/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=644b6b03b285fb0ace02d241d59483d98bc462729d8bb3608d5cad5532f3d2f0
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/patch
  be/make
  be/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

pkg_name=iptables
pkg_origin=be
pkg_version=1.6.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2')
pkg_source="http://netfilter.org/projects/iptables/files/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=0fc2d7bd5d7be11311726466789d4c65fb4c8e096c9182b56ce97440864f0cf5
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/make lilian/gcc lilian/bison
  lilian/flex
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

no_pie=true
source ../defaults.sh

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --enable-devel \
    --disable-static \
    --enable-shared \
    --enable-libipq \
    --disable-nftables \
    --with-xtlibdir=$pkg_prefix/lib/xtlibs

  make -j $(nproc)
}

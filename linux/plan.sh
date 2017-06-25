pkg_name=linux
pkg_origin=lilian
pkg_version="4.11.6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="https://cdn.kernel.org/pub/linux/kernel/v4.x/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="25539bfc34a01735d23ee80d5ef84054c65d1ea35dbd81be1cea339c21509631"
pkg_deps=(core/glibc)
pkg_build_deps=(
  lilian/make lilian/gcc lilian/perl
  lilian/elfutils lilian/bc lilian/diffutils
)

source ../defaults.sh

do_build() {
  make defconfig INSTALL_PATH="$pkg_prefix"
  sed "s/=m/=y/" -i .config
  make -j "$(nproc)"
}

do_install() {
  make -j "$(nproc)" INSTALL_MOD_PATH="$pkg_prefix" modules_install
  mkdir -p "${pkg_prefix}/boot"
  cp -a arch/x86/boot/bzImage "${pkg_prefix}/boot/"
}

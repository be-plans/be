pkg_name=grub
pkg_origin=lilian
pkg_version=2.02
pkg_source=ftp://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GNU GRUB is a Multiboot boot loader."
pkg_shasum="810b3798d316394f94096ec2797909dbf23c858e48f7b3830826b8daa06b7b0f"
pkg_upstream_url=https://www.gnu.org/software/grub/
pkg_license=('GPL-3.0')
pkg_bin_dirs=(bin sbin)
pkg_build_deps=(
  lilian/autoconf
  lilian/automake
  lilian/binutils
  lilian/bison
  core/cacerts
  lilian/diffutils
  core/dosfstools
  lilian/flex
  lilian/freetype
  lilian/gcc
  lilian/gettext
  lilian/git
  lilian/m4
  lilian/make
  lilian/python
  core/qemu
  core/rsync
  lilian/texinfo
)
pkg_deps=(core/glibc lilian/xz lilian/gettext lilian/pcre core/gcc-libs core/devicemapper core/elfutils lilian/bzip2 lilian/libcap)

do_setup() {
  if [[ ! -d /boot ]]; then
    mkdir /boot
    _GRUB_CLEANUP_BOOT="yes"
  fi
}

do_build() {
  sed -i "s/#! \/usr\/bin\/env bash/#!\/bin\/bash/" ./autogen.sh

  ./linguas.sh
  ./autogen.sh
  ./configure \
  --prefix="${pkg_prefix}" \
  --with-bootdir="/boot" \
  --target="x86_64" \
  --enable-efiemu \
  --enable-mm-debug \
  --enable-nls \
  --enable-device-mapper \
  --enable-cache-stats \
  --enable-boot-time \
  --enable-grub-mkfont \
  --with-grubdir="grub" \
  --disable-silent-rules \
  --disable-werror

  make -j "$(nproc)"
}

do_check() {
  make -j "$(nproc)" check
}

do_after() {
  if [[ -n "${_GRUB_CLEANUP_BOOT}" ]]; then
    rm -rf /boot
    info "Cleanup /boot"
  fi
}

pkg_name=grub
pkg_origin=core
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
  be/cacerts
  be/diffutils
  lilian/dosfstools
  lilian/flex
  lilian/freetype
  be/gcc
  lilian/gettext
  lilian/git
  lilian/m4
  be/make
  be/python
  lilian/qemu
  lilian/rsync
  lilian/texinfo
)
pkg_deps=(
  core/glibc core/gcc-libs lilian/xz
  lilian/gettext lilian/pcre lilian/devicemapper
  lilian/elfutils lilian/bzip2 lilian/libcap
)

no_pie=true
be_optimizations="-O2 -DNDEBUG -fomit-frame-pointer -fno-asynchronous-unwind-tables -ftree-vectorize -mavx -march=x86-64 -mtune=corei7-avx"
be_protection=" "
source ../defaults.sh

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

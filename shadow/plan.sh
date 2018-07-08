pkg_name=shadow
pkg_origin=core
pkg_version=4.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Password and account management tool suite."
pkg_upstream_url="https://github.com/shadow-maint/shadow"
pkg_license=('bsd')
pkg_source="https://github.com/shadow-maint/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="fc8c858381ad577a5c25ff5beb6ee60a34f8719c73e4e7c61e74188b4e54b741"
pkg_deps=(
  core/glibc
  lilian/attr
  lilian/acl
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  # Allow dots in usernames.
  #
  # Thanks to: http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/sys-apps/shadow/files/shadow-4.1.3-dots-in-usernames.patch
  patch -p1 -i "$PLAN_CONTEXT/dots-in-usernames.patch"

  # Disable the installation of the `groups` program as Coreutils provides a
  # better version.
  #
  # Thanks to:
  # http://www.linuxfromscratch.org/lfs/view/stable/chapter06/shadow.html
  # shellcheck disable=SC2016
  sed -i 's/groups$(EXEEXT) //' src/Makefile.in
  find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

  # Instead of using the default crypt method, use the more secure SHA-512
  # method of password encryption, which also allows passwords longer than 8
  # characters.
  #
  # Thanks to:
  # http://www.linuxfromscratch.org/lfs/view/stable/chapter06/shadow.html
  sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' etc/login.defs
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-acl \
    --with-attr \
    --with-group-name-max-length=32 \
    --without-selinux \
    --without-libpam

  make -j "$(nproc)"
}

do_check() {
  make check
}

do_install() {
  do_default_install

  # Move all binaries in `sbin/` into `bin/` as this isn't handled by
  # `./configure`.
  mv "$pkg_prefix/sbin"/* "$pkg_prefix/bin/"
  rm -rf "$pkg_prefix/sbin"

  # Install the license
  install -Dm644 COPYING "$pkg_prefix/share/licenses/COPYING"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    lilian/gcc/7.1.0/20170624225400
  )
fi

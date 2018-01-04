pkg_name=util-linux
pkg_origin=core
pkg_version=2.30
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Miscellaneous system utilities for Linux"
pkg_upstream_url=https://www.kernel.org/pub/linux/utils/util-linux
pkg_source=https://www.kernel.org/pub/linux/utils/${pkg_name}/v${pkg_version%.?}/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=c208a4ff6906cb7f57940aa5bc3a6eed146e50a7cc0a092f52ef2ab65057a08d
pkg_deps=(core/glibc be/zlib be/ncurses)
pkg_build_deps=(
  be/coreutils be/diffutils be/patch
  be/make be/gcc be/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --sbindir="$pkg_prefix/bin" \
    --localstatedir="$pkg_svc_var_path/run" \
    --without-python \
    --without-slang \
    --without-systemd \
    --without-systemdsystemunitdir \
    --disable-use-tty-group \
    --disable-chfn-chsh \
    --disable-login \
    --disable-nologin \
    --disable-su \
    --disable-setpriv \
    --disable-runuser \
    --disable-pylibmount
  make -j $(nproc)
}

do_install() {
  make -j $(nproc) install usrsbin_execdir="$pkg_prefix/bin"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc be/coreutils be/sed be/diffutils be/make be/patch)
fi

pkg_name=inetutils
pkg_origin=core
pkg_version=1.9.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=849d96f136effdef69548a940e3e0ec0624fc0c81265296987986a0dd36ded37
pkg_deps=(core/glibc lilian/libcap lilian/ncurses)
pkg_build_deps=(
  be/coreutils be/diffutils be/patch
  be/make be/gcc be/sed lilian/grep
)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  # Configure flag notes:
  #
  # * `--disable-logger`: prevents building the `logger`, as the version from
  #   Util-linux will be used instead
  # * `--disable-whois`: prevents building the `whois` tool, which is out of
  #   date
  # * `--disable-r*`: prevents building of obsolete programs such as `rlogin`,
  #   `rsh`, etc.
  # * `--disable-servers`: prevents the building of the server components in
  #   this codebase, such as `telnetd`, `ftpd`, etc.--a dedicated Plan for
  #   any of these service components is much preferred
  ./configure \
    --prefix=$pkg_prefix \
    --disable-logger \
    --disable-whois \
    --disable-rcp \
    --disable-rexec \
    --disable-rlogin \
    --disable-rsh \
    --disable-servers
  make -j "$(nproc)"
}

do_install() {
  do_default_install

  # `libexec/` directory is not used
  rm -rfv $pkg_prefix/libexec
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc be/coreutils be/sed lilian/grep)
fi

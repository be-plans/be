pkg_name=dejagnu
pkg_origin=core
pkg_version=1.6
pkg_license=('GPL-2.0')
pkg_upstream_url="https://www.gnu.org/software/dejagnu/"
pkg_description="A framework for testing other programs."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=00b64a618e2b6b581b16eb9131ee80f721baa2669fa0cdee93c500d1a652d763
pkg_deps=(lilian/expect)
pkg_build_deps=(
  be/coreutils be/diffutils be/patch
  be/make be/gcc be/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)

source ../defaults.sh

do_check() {
  # The test-suite needs to have a non-empty stdin, see:
  # http://lists.gnu.org/archive/html/bug-dejagnu/2003-06/msg00002.html
  #
  # Provide `runtest' with a log name, otherwise it tries to run `whoami`,
  # which fails when in a chroot.
  LOGNAME="dejagnu-logger" make check < /dev/zero
}

do_install() {
  do_default_install

  # Set an absolute path `expect` in the `runtest` binary
  sed \
    -e "s,expectbin=expect,expectbin=$(pkg_path_for expect)/bin/expect,g" \
    -i "$pkg_prefix/bin/runtest"
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

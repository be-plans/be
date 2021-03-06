pkg_name=make
pkg_origin=core
pkg_version=4.2.1
pkg_description="\
Make is a tool which controls the generation of executables and other \
non-source files of a program from the program's source files.\
"
pkg_upstream_url="https://www.gnu.org/software/make/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="d6e262bf3601b42d2b1e4ef8310029e1dcf20083c5446b4b7aa67081fdffc589"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/bash
  lilian/gettext
  lilian/gzip
  lilian/perl
  lilian/binutils
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  # Don't look for library dependencies in the root system (i.e. `/lib`,
  # `/usr/lib`, etc.)
  patch -p1 -i "$PLAN_CONTEXT/no-sys-dirs.patch"

  # Work around an error caused by Glibc 2.27
  #
  # Thanks to: http://www.linuxfromscratch.org/lfs/view/8.2/chapter05/make.html
  sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c
}

do_check() {
  # Force `ar` to not run in deterministic mode, as the testsuite relies on
  # UID, GID, timestamp and file mode values to be correctly stored.
  #
  # Thanks to: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=782750
  mkdir -pv wrappers
  cat <<EOF > wrappers/ar
#!$(pkg_path_for bash)/bin/sh
exec $(pkg_path_for binutils)/bin/ar U\$@
EOF
  chmod -v 0744 wrappers/ar

  # The `PERL_USE_UNSAFE_INC=1` variable allows the test suite to run with Perl
  # 5.26 (resolves a "Can't locate driver" error).
  #
  # Thanks to:
  # * https://lists.gnu.org/archive/html/bug-make/2017-03/msg00040.html
  # * https://bugs.archlinux.org/task/55127
  env PATH="$(pwd)/wrappers:$PATH" PERL_USE_UNSAFE_INC=1 make check
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
    lilian/binutils/2.28/20170624225044
    lilian/gcc/7.1.0/20170624225400
    lilian/coreutils/8.27/20170624233515
    lilian/sed/4.4/20170624233625
    lilian/bash/4.3.42/20170624233914
    lilian/perl/5.24.1/20170624234348
    lilian/diffutils/3.6/20170624234540
    lilian/gettext/0.19.8.1/20170624234650
    lilian/gzip/1.8/20170624234853
  )
fi

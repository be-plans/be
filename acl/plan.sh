pkg_name=acl
pkg_origin=lilian
pkg_version=2.2.52
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('lgpl')
pkg_source=http://download.savannah.gnu.org/releases/$pkg_name/$pkg_name-${pkg_version}.src.tar.gz
pkg_shasum=179074bb0580c06c4b4137be4c5a92a701583277967acdb5546043c7874e0d23
pkg_deps=(core/glibc lilian/attr)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/gettext
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

compiler_flags() {
  local -r optimizations="-O2 -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags

  # Fix a bug that causes `getfacl -e` to segfault on overly long group name.
  #
  # Thanks to: http://www.linuxfromscratch.org/lfs/view/stable/chapter06/acl.html
  sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c
}

do_install() {
  make install install-dev install-lib
  chmod -v 755 $pkg_prefix/lib/libacl.so
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc)
fi

pkg_name=tar
pkg_origin=lilian
pkg_version=1.29
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation."
pkg_upstream_url=https://www.gnu.org/software/tar/
pkg_license=('GPL-3.0')
pkg_source=http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=402dcfd0022fd7a1f2c5611f5c61af1cd84910a760a44a688e18ddbff4e9f024
pkg_deps=(core/glibc lilian/acl lilian/attr)
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/sed
)
pkg_bin_dirs=(bin)

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
}

do_build() {
  # * `FORCE_UNSAFE_CONFIGURE` forces the test for `mknod` to be run as root
  FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix="$pkg_prefix"
  make -j $(nproc)
}

do_check() {
  make check
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/coreutils lilian/sed)
fi

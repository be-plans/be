pkg_name=musl
pkg_origin=lilian
pkg_version=1.1.16
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://www.musl-libc.org/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=937185a5e5d721050306cf106507a006c3f1f86d86cd550024ea7be909071011
pkg_deps=()
pkg_build_deps=(
  lilian/coreutils lilian/diffutils lilian/patch
  lilian/make lilian/gcc lilian/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

compiler_flags() {
  local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} "
  export CXXFLAGS="${CXXFLAGS} -std=gnu++1z ${optimizations} ${protection} "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags

  stack_size="2097152"
  build_line "Setting default stack size to '$stack_size' from default of '81920'"
  sed -i "s/#define DEFAULT_STACK_SIZE .*/#define DEFAULT_STACK_SIZE $stack_size/" \
    src/internal/pthread_impl.h
  
  return 0
}

do_build() {
  ./configure \
    --prefix=$pkg_prefix \
    --syslibdir=$pkg_prefix/lib
  make -j$(nproc)
}

do_install() {
  do_default_install

  # Install license
  install -Dm0644 COPYRIGHT $pkg_prefix/share/licenses/COPYRIGHT
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/gcc lilian/coreutils lilian/sed lilian/diffutils lilian/make lilian/patch)
fi

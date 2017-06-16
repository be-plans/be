_compiler_flags() {
  local __lto_flag
  if [ -n "${pkg_bin_dirs}" ] && [ -z "${pkg_lib_dirs}" ] && [ -n "${use_lto}" ]; then
    export LD="gcc-ld"
    export LD_FOR_TARGET="${LD}"
    __lto_flag="-fuse-linker-plugin -flto"
  fi

  __generic_flags="-pipe -Wno-error -Wno-error=implicit-fallthrough "
  __optimizations="-O2 -DNDEBUG -fomit-frame-pointer -fno-asynchronous-unwind-tables -ftree-vectorize -m64 -mavx -march=corei7-avx -mtune=corei7-avx ${__lto_flag}"
  __protection="-fstack-protector-strong"

  export CFLAGS="${CFLAGS} ${__optimizations} ${__protection} ${__generic_flags}"
  export CXXFLAGS="${CXXFLAGS} -std=gnu++1z -fuse-cxa-atexit ${__optimizations} ${__protection} ${__generic_flags}"
  export GCC_CXXFLAGS="${CXXFLAGS} -std=gnu++14 -fuse-cxa-atexit ${__optimizations} ${__protection} ${__generic_flags}"
  export CPPFLAGS="${CPPFLAGS} ${__generic_flags} "
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_default_prepare() {
  _compiler_flags
}

do_default_build() {
    ./configure --prefix="${pkg_prefix:?}"
    make -j "$(nproc)"
}

do_default_install() {
    make -j "$(nproc)" install
}

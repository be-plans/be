_compiler_flags() {
  # if exports only libs
  if [ -z "${pkg_bin_dirs}" ] && [ -n "${pkg_lib_dirs}" ] && [ -z "${no_pie}" ]; then
      be_pic_pie="${be_pic_pie:--fpic}"
  fi

  # if exports executables
  if [ -n "${pkg_bin_dirs}" ] && [ -z "${no_pie}" ]; then
    # if exports libs
    if [ -n "${pkg_lib_dirs}" ]; then
      be_pic_pie="${be_pic_pie:--fpic -DPIC}"
    else # if exports Only executables
      be_pic_pie="${be_pic_pie:--fpie -DPIE}"
    fi
  fi

  # if exports only executables and the user wants LTO
  if [ -n "${pkg_bin_dirs}" ] && [ -z "${pkg_lib_dirs}" ] && [ -n "${use_lto}" ]; then
    export LD="gcc-ld"
    export LD_FOR_TARGET="${LD}"
    be_lto_flag="${be_lto_flag:--fuse-linker-plugin -flto}"
  fi

  be_generic_flags="${be_generic_flags:--pipe -Wno-error -Wno-error=implicit-fallthrough}"
  be_optimizations="${be_optimizations:--O2 -DNDEBUG -fomit-frame-pointer -fno-asynchronous-unwind-tables -ftree-vectorize -m64 -mavx -march=corei7-avx -mtune=corei7-avx ${lto_flag}}"
  be_protection="${be_protection:--fstack-protector-strong}"
  be_cxxstd="${be_cxxstd:--std=gnu++1z}"
  be_ldflags="${be_ldflags:--Wl,-Bsymbolic-functions -Wl,-z,relro}"

  export CFLAGS="${CFLAGS} ${be_optimizations} ${be_protection} ${be_generic_flags} ${be_pic_pie} "
  export CXXFLAGS="${CXXFLAGS} ${be_cxxstd} -fuse-cxa-atexit ${be_optimizations} ${be_protection} ${be_generic_flags} ${be_pic_pie} "
  export CPPFLAGS="${CPPFLAGS} ${be_generic_flags} "
  export LDFLAGS="${LDFLAGS} ${be_ldflags} ${be_lto_flag} "

  be_pie_ld="${be_pie_ld:--pie}"

  if [ -z "${no_pie}" ] && [ -z "$(echo "${LDFLAGS}" | grep '-static')" ]; then
    local -r pic_pie="$(echo "${be_pic_pie}" | cut -d ' ' -f 1)"
    export LDFLAGS="${LDFLAGS}${pic_pie} ${be_pie_ld} "
  fi
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

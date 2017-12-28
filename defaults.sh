# Parsing something like this:
# pkg_disabled_features=(
#   lto
#   pie
#   relro
# )
#
_parse_disabled_features() {
  _be_no_lto=
  _be_no_pic=
  _be_no_relro=

  test -z "${pkg_disabled_features}" && return 0;
  for disabled_feature in "${pkg_disabled_features[@]}"; do
    case "${disabled_feature}" in
      lto)   _be_no_lto=true ;;
      pie)   _be_no_pic=true ;;
      relro) _be_no_relro=true ;;
    esac
  done
}

_compiler_flags() {
  if [ -z "${_be_no_pic}" ]; then
    # if exports only libs
    if [ -z "${pkg_bin_dirs}" ] && [ -n "${pkg_lib_dirs}" ]; then
      be_pic_flag="${be_pic_flag:--fpic}"
      be_pic_ld="${be_pic_ld:--pic}"
    fi

    # if exports only executables
    if [ -n "${pkg_bin_dirs}" ] && [ -z "${pkg_lib_dirs}" ]; then
      be_pic_flag="${be_pic_flag:--fpie}"
      be_pic_ld="${be_pic_ld:--pie}"
    fi

    # We do not use PIC/PIE if have libs and executables(would be risky and flaky)
  fi

  # if exports only executables and the user wants LTO - still might be building static libraries...
  if [ -n "${pkg_bin_dirs}" ] && [ -z "${pkg_lib_dirs}" ] && [ -z "${_be_no_lto}" ]; then
    export LD="gold"
    export LD_FOR_TARGET="${LD}"
    be_lto_flag="${be_lto_flag:--fuse-linker-plugin -flto}"
  fi

  be_generic_flags="${be_generic_flags:--pipe -Wno-error -Wno-error=implicit-fallthrough}"
  be_optimizations="${be_optimizations:--O3 -DNDEBUG -fomit-frame-pointer -fno-asynchronous-unwind-tables -ftree-vectorize -m64 -mavx -march=x86-64 -mtune=corei7-avx ${be_lto_flag}}"
  be_protection="${be_protection:--fstack-protector-strong}"
  be_cxxstd="${be_cxxstd:--std=gnu++1z}"
  test -z "${_be_no_relro}" && be_ldflags="${be_ldflags:--Wl,-Bsymbolic-functions -Wl,-z,relro}"

  export CFLAGS="${CFLAGS} ${be_optimizations} ${be_protection} ${be_generic_flags} ${be_pic_flag} "
  export CXXFLAGS="${CXXFLAGS} ${be_cxxstd} -fuse-cxa-atexit ${be_optimizations} ${be_protection} ${be_generic_flags} ${be_pic_flag} "
  export CPPFLAGS="${CPPFLAGS} ${be_generic_flags} "
  export LDFLAGS="${LDFLAGS} ${be_ldflags} ${be_lto_flag} "

  if [ -z "${_be_no_pic}" ] && [ -z "$(echo "${LDFLAGS}" | grep '-static')" ]; then
    export LDFLAGS="${LDFLAGS}${be_pic_flag} ${be_pic_ld} "
  fi
}

do_default_prepare() {
  _parse_disabled_features
  _compiler_flags
}

do_default_build() {
  ./configure --prefix="${pkg_prefix:?}"
  make -j "$(nproc)"
}

do_default_install() {
  make -j "$(nproc)" install
}

export BE_ORIGIN="${BE_ORIGIN:-be}"
pkg_origin="${BE_ORIGIN}"

# Parsing something like this:
# pkg_disabled_features=(
#   lto
#   pic
#   relro
#   glibc
# )
#
_parse_disabled_features() {
  _be_no_lto=
  _be_no_pic=
  _be_no_relro=
  _be_no_glibc=

  test -z "${pkg_disabled_features}" && return 0;
  for disabled_feature in "${pkg_disabled_features[@]}"; do
    case "${disabled_feature}" in
      lto)   _be_no_lto=true ;;
      pic)   _be_no_pic=true ;;
      relro) _be_no_relro=true ;;
      glibc) _be_no_glibc=true ;;
    esac
  done
}

_compiler_flags() {
  export BE_ARCH="${BE_ARCH:-x86-64}"
  export BE_TUNE="${BE_TUNE:-corei7-avx}"
  export BE_TUNE_EXTRA="${BE_TUNE_EXTRA:--m64 -mavx}"
  export BE_CXXSTD="${BE_CXXSTD:--std=gnu++1z}"

  # Disable temporarily PIC/PIE and LTO - unreliable
  _be_no_lto=true
  _be_no_pic=true

  if [ -z "${_be_no_pic}" ]; then
    # if exports only libs
    if [ -z "${pkg_bin_dirs}" ] && [ -n "${pkg_lib_dirs}" ]; then
      be_pic_flag="${be_pic_flag:--fpic}"
      be_pic_ld="${be_pic_ld:--pic}"
    fi

    # if exports only executables
    if [ -n "${pkg_bin_dirs}" ] && [ -z "${pkg_lib_dirs}" ]; then
      be_pic_flag="${be_pic_flag:--fpie}"
      be_pic_ld="${be_pic_ld:--pic}"
    fi

    # We do not use PIC/PIE if have libs and executables(would be risky and flaky)
  fi

  # if exports only executables and the user wants LTO - still might be building static libraries...
  if [ -n "${pkg_bin_dirs}" ] && [ -z "${pkg_lib_dirs}" ] && [ -z "${_be_no_lto}" ]; then
    export LD="gold"
    export LD_FOR_TARGET="${LD}"
    be_lto_flag="${be_lto_flag:--fuse-linker-plugin -flto}"
  fi

  test -z "${_be_no_glibc}" && be_gnu_source="-D_GNU_SOURCE"
  be_generic_flags="${be_generic_flags:--pipe -Wno-error -Wno-error=implicit-fallthrough}"
  be_optimizations="${be_optimizations:--fPIC -O3 -DNDEBUG ${be_gnu_source} -fomit-frame-pointer -fno-asynchronous-unwind-tables -ftree-vectorize -floop-strip-mine -floop-block -fgraphite-identity ${BE_TUNE_EXTRA} -march=${BE_ARCH:?} -mtune=${BE_TUNE:?} ${be_lto_flag}}"
  be_protection="${be_protection:--fstack-protector-strong}"
  be_cxxstd="${be_cxxstd:-${BE_CXXSTD}}"
  test -z "${_be_no_relro}" && be_ldflags="${be_ldflags:--Wl,-Bsymbolic-functions -Wl,-z,relro}"
  be_ldflags="${be_ldflags} -Wl,--as-needed"

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

do_perl_setup_environment() {
  test -z "${1}" && echo "Please pass the Module's Perl INC path" && exit 1

  local -r inc_path="${1}"
  eval "$(perl -I${inc_path} -Mlocal::lib=${pkg_prefix})"

  # Avoid inserting an empty ":" at the beginning of the path
  if [ -z "${PERL5LIB}" ]; then
    set_runtime_env -f PERL5LIB "${inc_path}"
  else
    # Avoiding: PERL5LIB=some_path:${inc_path}/invalid_path:some_other_path
    local -r regex="^([ tab]*${inc_path}[ tab]*)$|^([ tab]*${inc_path}:{1})|:{1}${inc_path}:{1}|(:{1}${inc_path}[ tab]*)$"

    # If the path is already exported, then skip
    if   [ -z "$(echo "${PERLLIB}"  | grep -E "${regex}")" ] \
      && [ -z "$(echo "${PERL5LIB}" | grep -E "${regex}")" ]; then
      set_runtime_env -f PERL5LIB "${PERL5LIB}:${inc_path}"
    fi
  fi
}

be_remove_compiler_flag() {
  test -z "${1}" && echo "Please pass a compiler flag" && exit 1
  local -r compiler_flag="${1}"

  export CFLAGS="$(echo "${CFLAGS}" | sed "s/[ tab]*${compiler_flag}[ tab]*/ /g")"
  export CXXFLAGS="$(echo "${CXXFLAGS}" | sed "s/[ tab]*${compiler_flag}[ tab]*/ /g")"
  export CPPFLAGS="$(echo "${CPPFLAGS}" | sed "s/[ tab]*${compiler_flag}[ tab]*/ /g")"
}

be_remove_linker_flag() {
  test -z "${1}" && echo "Please pass a linker flag" && exit 1
  local -r linker_flag="${1}"

  export LDFLAGS="$(echo "${LDFLAGS}" | sed "s/[ tab]*${linker_flag}[ tab]*/ /g")"
}

_compiler_flags() {
  local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} -Wno-error "
  export CXXFLAGS="${CXXFLAGS} -std=gnu++1z ${optimizations} ${protection} -Wno-error "
  export CPPFLAGS="${CPPFLAGS} -Wno-error "
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_default_prepare() {
  _compiler_flags
}

do_default_build() {
    if [ -f "$(pwd -P)/CMakeLists.txt" ]; then
        (
            local -r cmake_build_dir="cmake_build"
            rm -rf "${cmake_build_dir:?}"
            mkdir -p "${cmake_build_dir:?}"
            cd "${cmake_build_dir:?}" || exit 1

            cmake -G "Unix Makefiles" \
                -DCMAKE_BUILD_TYPE=Release \
                -DCMAKE_INSTALL_PREFIX="${pkg_prefix:?}" \
                -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
                ..

            make -j $(nproc)
        )
    else
        ./configure --prefix="${pkg_prefix:?}"
        make -j $(nproc)
    fi
}

do_default_install() {
    if [ -f "$(pwd -P)/CMakeLists.txt" ] && [ -d "$(pwd -P)/cmake_build" ]; then
        build_line "Inside CMake install"
        (
            local -r cmake_build_dir="cmake_build"
            cd "${cmake_build_dir:?}" || exit 1
            make -j $(nproc) install
        )
    else
        build_line "Inside autotools install"
        make -j $(nproc) install
    fi
}

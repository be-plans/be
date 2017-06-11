pkg_name=python2
pkg_distname=Python
pkg_version=2.7.13
pkg_origin=lilian
pkg_license=('Python-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Python is a programming language that lets you work quickly
  and integrate systems more effectively."
pkg_upstream_url=https://www.python.org/
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_source=https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tgz
pkg_shasum=a4f05a0720ce0fd92626f0278b6b433eee9a6173ddf2bced7957dfb599a5ece1
pkg_deps=(
  lilian/bzip2
  core/gcc-libs
  lilian/gdbm
  core/glibc
  lilian/ncurses
  lilian/openssl 
  lilian/readline
  lilian/sqlite
  lilian/zlib
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/gcc
  lilian/gdb
  core/linux-headers
  lilian/make
  lilian/util-linux
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include Include)
pkg_interpreters=(bin/python bin/python2 bin/python2.7)

compiler_flags() {
  local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} -Wno-error "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} -Wno-error "
  export CPPFLAGS="${CPPFLAGS} -Wno-error "
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags

  sed -i.bak 's/#zlib/zlib/' Modules/Setup.dist
  sed -i -re "/(SSL=|_ssl|-DUSE_SSL|-lssl).*/ s|^#||" Modules/Setup.dist

  # Allow embedded sqlite to load extensions
  # Uncertain if this is absolutely required, leaving commented for now.
  # https://docs.python.org/2/library/sqlite3.html#f1
  # sed -i 's/sqlite_defines.append(("SQLITE_OMIT_LOAD_EXTENSION", "1"))//g' setup.py
}

do_build() {
    ./configure --prefix="$pkg_prefix" \
                --enable-shared \
                --enable-unicode=ucs4 \
                --with-ensurepip
    make -j $(nproc)
}

do_check() {
  make test
}

do_install() {
  do_default_install

  platlib=$(python -c "import sysconfig;print(sysconfig.get_path('platlib'))")
  cat <<EOF > "$platlib/_manylinux.py"
# Disable binary manylinux1(CentOS 5) wheel support
manylinux1_compatible = False
EOF
}

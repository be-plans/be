pkg_origin=lilian
pkg_name=python
pkg_distname=Python
pkg_version=3.6.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Python-2.0')
pkg_description="Python is a programming language that lets you work quickly \
  and integrate systems more effectively."
pkg_upstream_url="https://www.python.org"
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_source=https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tar.xz
pkg_shasum=a01810ddfcec216bcdb357a84bfaafdfaa0ca42bbdaa4cb7ff74f5a9961e4041
pkg_deps=(
  lilian/bzip2
  core/gcc-libs
  lilian/gdbm
  core/glibc
  lilian/ncurses
  lilian/openssl 
  core/readline
  core/sqlite
  lilian/zlib
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/gcc
  core/linux-headers
  lilian/make
  core/util-linux
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_interpreters=(bin/python bin/python3 bin/python3.5)

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

  sed -i.bak 's/#zlib/zlib/' Modules/Setup.dist
  sed -i -re "/(SSL=|_ssl|-DUSE_SSL|-lssl).*/ s|^#||" Modules/Setup.dist
}

do_build() {
  export LDFLAGS="$LDFLAGS -lgcc_s"
  ./configure --prefix="$pkg_prefix" \
              --enable-loadable-sqlite-extensions \
              --enable-shared \
              --with-ensurepip
  make -j$(nproc)
}

do_check() {
  make test
}

do_install() {
  do_default_install

  # link python3.6 to python for pkg_interpreters
  ln -rs "$pkg_prefix/bin/pip3.6" "$pkg_prefix/bin/pip"
  ln -rs "$pkg_prefix/bin/pydoc3.6" "$pkg_prefix/bin/pydoc"
  ln -rs "$pkg_prefix/bin/python3.6" "$pkg_prefix/bin/python"
  ln -rs "$pkg_prefix/bin/python3.6-config" "$pkg_prefix/bin/python-config"

  platlib=$(python -c "import sysconfig;print(sysconfig.get_path('platlib'))")
  cat <<EOF > "$platlib/_manylinux.py"
# Disable binary manylinux1(CentOS 5) wheel support
manylinux1_compatible = False
EOF
}

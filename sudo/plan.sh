pkg_name=sudo
pkg_origin=lilian
pkg_version=1.8.20p2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Execute a command as another user"
pkg_upstream_url="https://www.sudo.ws/"
pkg_license=('ISC')
pkg_source=ftp://ftp.sudo.ws/pub/sudo/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=bd42ae1059e935f795c69ea97b3de09fe9410a58a74b5d5e6836eb5067a445d9
pkg_build_deps=(
  lilian/diffutils
  lilian/file
  lilian/gcc
  lilian/make
)
pkg_deps=(
  lilian/coreutils
  core/glibc
  lilian/vim
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)

compiler_flags() {
  local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong"
  export CFLAGS="${CFLAGS} ${optimizations} ${protection} "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
  do_default_prepare
  compiler_flags

  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi

  # Export variables to the direct path of executables
  MVPROG="$(pkg_path_for coreutils)/bin/mv"
  export MVPROG
  VIPROG="$(pkg_path_for vim)/bin/vi"
  export VIPROG
}

do_build() {
  ./configure --prefix="$pkg_prefix" --with-editor="$VIPROG" --with-env-editor
  make -j $(nproc)
}

do_check() {
  # Due to how file permissions are preserved during packaging, we must
  # set a particular file to be owned by root for the `testsudoers/test3`
  # regression test, which compares sudo permissions against a file with
  # root ownership.
  chown root:root plugins/sudoers/regress/testsudoers/test3.d/root

  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

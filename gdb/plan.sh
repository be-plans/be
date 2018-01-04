pkg_name=gdb
pkg_origin=core
pkg_version=8.0.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="GDB, the GNU Project debugger, allows you to see what is going on 'inside' another program while it executes -- or what another program was doing at the moment it crashed."
pkg_upstream_url="https://www.gnu.org/software/gdb/"
pkg_source="http://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=3dbd5f93e36ba2815ad0efab030dcd0c7b211d7b353a40a53f4c02d7d56295e3
pkg_deps=(
  core/glibc
  be/readline
  be/zlib
  be/xz
  be/ncurses
  be/expat
  be/guile
  be/bdwgc
  be/python
)
pkg_build_deps=(
  be/coreutils
  be/pkg-config
  be/diffutils
  lilian/expect
  lilian/dejagnu
  be/patch
  be/make
  be/gcc
  lilian/texinfo
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

pkg_disabled_features=(pic)
source ../defaults.sh

do_build() {
  ./configure \
    --build=x86_64-linux-gnu \
    --host=x86_64-linux-gnu \
    --prefix="${pkg_prefix}" \
    --sysconfdir="${pkg_svc_config_path}" \
    --localstatedir="${pkg_svc_var_path}" \
    --libexecdir="${pkg_prefix}/lib/gdb" \
    --enable-tui \
    --disable-maintainer-mode \
    --disable-dependency-tracking \
    --disable-silent-rules \
    --disable-gdbtk \
    --disable-shared \
    --with-pkgversion="The Habitat Maintainers ${pkg_version}/${pkg_release}" \
    --with-system-readline \
    --with-system-zlib \
    --with-lzma \
    --with-expat \
    --with-guile \
    --without-babeltrace \
    --with-system-gdbinit="${pkg_svc_config_path}/gdb/gdbinit" \
    --with-python=python3

  make -j "$(nproc)"
}

do_check() {
  make -j "$(nproc)" check
}

do_install() {
  do_default_install

  # Clean up files that ship with binutils and may conflict
  rm -fv "${pkg_prefix}/lib/{libbfd,libopcodes}.a"
  rm -fv "${pkg_prefix}/include/{ansidecl,bfd,bfdlink,dis-asm,plugin-api,symcat}.h"
  rm -fv "${pkg_prefix}/share/info/bfd.info"
}

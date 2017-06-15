pkg_name=gdb
pkg_origin=lilian
pkg_version=8.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="GDB, the GNU Project debugger, allows you to see what is going on 'inside' another program while it executes -- or what another program was doing at the moment it crashed."
pkg_upstream_url="https://www.gnu.org/software/gdb/"
pkg_source="http://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=f6a24ffe4917e67014ef9273eb8b547cb96a13e5ca74895b06d683b391f3f4ee
pkg_deps=(
  core/glibc
  lilian/readline
  lilian/zlib
  lilian/xz
  lilian/ncurses
  lilian/expat
  lilian/guile
  lilian/bdwgc
  lilian/python
)
pkg_build_deps=(
  lilian/coreutils
  lilian/pkg-config
  lilian/diffutils
  lilian/expect
  lilian/dejagnu
  lilian/patch
  lilian/make
  lilian/gcc
  lilian/texinfo
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

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

pkg_origin=core
pkg_name=glib
pkg_version="2.50.3"
pkg_description="$(cat << EOF
  GLib is a general-purpose utility library, which provides many useful data
  types, macros, type conversions, string utilities, file utilities, a
  mainloop abstraction, and so on. It works on many UNIX-like platforms, as
  well as Windows and OS X.
EOF
)"
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_license=('LGPL-2.0')
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_upstream_url="https://developer.gnome.org/glib/"
pkg_shasum="82ee94bf4c01459b6b00cb9db0545c2237921e3060c0b74cff13fbc020cfd999"
pkg_deps=(
  be/coreutils
  lilian/elfutils
  core/glibc
  lilian/libffi
  lilian/libiconv
  be/pcre
  be/util-linux
  be/zlib
)
pkg_build_deps=(
  lilian/dbus
  be/diffutils
  be/file
  be/gcc
  be/gettext
  lilian/libxslt
  be/make
  be/perl
  be/pkg-config
  be/python
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_interpreters=(be/coreutils)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-libiconv \
    --disable-gtk-doc \
    --disable-fam
  make -j $(nproc)
}

do_after() {
  fix_interpreter "$pkg_prefix/bin/*" be/coreutils bin/env
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}

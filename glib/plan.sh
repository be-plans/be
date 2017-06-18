pkg_origin=lilian
pkg_name=glib
pkg_version='2.53.2'
pkg_description="$(cat << EOF
  GLib is a general-purpose utility library, which provides many useful data
  types, macros, type conversions, string utilities, file utilities, a
  mainloop abstraction, and so on. It works on many UNIX-like platforms, as
  well as Windows and OS X.
EOF
)"
pkg_source="http://download.gnome.org/sources/glib/$(echo $pkg_version | cut -d. -f1-2)/$pkg_name-$pkg_version.tar.xz"
pkg_license=('LGPL-2.0')
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_upstream_url="https://developer.gnome.org/glib/stable/glib.html"
pkg_shasum="ada8e2b22f52de1950dd327bdef80a7e41e6da5ddc85fb81d9a8439e9dff8e0d"
pkg_deps=(
  lilian/libffi
  lilian/libiconv
  lilian/pcre
)
pkg_build_deps=(
  lilian/make
  lilian/glibc
  lilian/pkg-config
  lilian/gcc
  lilian/gettext
  lilian/zlib
  lilian/python
  lilian/util-linux
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-libiconv \
    --with-pcre=system \
    --disable-fam \
    --disable-gtk-doc
  make -j $(nproc)
}

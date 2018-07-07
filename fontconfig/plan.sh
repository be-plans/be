pkg_name=fontconfig
pkg_version=2.11.95
pkg_origin=core
pkg_license=('fontconfig')
pkg_description="Fontconfig is a library for configuring and
  customizing font access."
pkg_upstream_url=https://www.freedesktop.org/wiki/Software/fontconfig/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.freedesktop.org/software/fontconfig/release/${pkg_name}-${pkg_version}.tar.bz2
pkg_filename=${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=7b165eee7aa22dcc1557db56f58d905b6a14b32f9701c79427452474375b4c89
pkg_deps=(
  be/bzip2
  core/glibc
  be/zlib
  lilian/freetype
  lilian/libpng
  be/expat
  be/gcc-libs
)
pkg_build_deps=(be/gcc be/make be/coreutils be/python
                be/pkg-config be/diffutils be/libtool
                be/m4 be/automake be/autoconf be/file be/patch)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_prepare() {
  do_default_prepare

  # Set freetype paths
  export FREETYPE_CFLAGS="$CFLAGS"
  build_line "Setting FREETYPE_CFLAGS=$FREETYPE_CFLAGS"
  export FREETYPE_LIBS
  FREETYPE_LIBS="$LDFLAGS -Wl,--rpath -Wl,$(pkg_path_for freetype)/lib -lfreetype -lz"
  build_line "Setting FREETYPE_LIBS=$FREETYPE_LIBS"

  # Add "freetype2" to include path
  export CFLAGS
  CFLAGS="$CFLAGS -I$(pkg_path_for freetype)/include/freetype2"
  build_line "Setting CFLAGS=$CFLAGS"

  # Borrowing this pro tip from ArchLinux!
  # https://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/fontconfig#n34
  # this seems to run libtoolize though...
  autoreconf -fi

  _file_path="$(pkg_path_for file)/bin/file"
  _uname_path="$(pkg_path_for coreutils)/bin/uname"

  sed -e "s#/usr/bin/file#${_file_path}#g" -i configure
  sed -e "s#/usr/bin/uname#${_uname_path}#g" -i configure

  patch -p1 < "$PLAN_CONTEXT/glibc-2.25+.patch"
}

do_build() {
  ./configure --sysconfdir="$pkg_prefix/etc" \
              --prefix="$pkg_prefix" \
              --disable-static \
              --mandir="$pkg_prefix/man"
  make -j $(nproc)
}

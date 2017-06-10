pkg_name=fontconfig
pkg_version=2.11.94
pkg_origin=lilian
pkg_license=('fontconfig')
pkg_description="Fontconfig is a library for configuring and
  customizing font access."
pkg_upstream_url=https://www.freedesktop.org/wiki/Software/fontconfig/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.freedesktop.org/software/fontconfig/release/${pkg_name}-${pkg_version}.tar.bz2
pkg_filename=${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=d763c024df434146f3352448bc1f4554f390c8a48340cef7aa9cc44716a159df
pkg_deps=(
  lilian/bzip2
  core/glibc
  lilian/zlib
  core/freetype
  core/libpng
  lilian/expat
  core/gcc-libs
)
pkg_build_deps=(lilian/gcc lilian/make lilian/coreutils lilian/python
                lilian/pkg-config lilian/diffutils core/libtool
                lilian/m4 core/automake core/autoconf core/file)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_prepare() {
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
}

do_build() {
  ./configure --sysconfdir="$pkg_prefix/etc" \
              --prefix="$pkg_prefix" \
              --disable-static \
              --mandir="$pkg_prefix/man"
  make
}

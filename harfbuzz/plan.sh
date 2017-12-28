pkg_name=harfbuzz
pkg_origin=be
pkg_version=1.4.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/HarfBuzz/"
pkg_description="HarfBuzz is an OpenType text shaping engine"
pkg_source=http://www.freedesktop.org/software/harfbuzz/release/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=21a78b81cd20cbffdb04b59ac7edfb410e42141869f637ae1d6778e74928d293
pkg_deps=(
  lilian/cairo
  lilian/expat
  lilian/freetype
  lilian/fontconfig
  lilian/glib
  core/glibc
  lilian/icu
  lilian/libpng
  lilian/pixman
  lilian/pcre
  lilian/zlib
)
pkg_build_deps=(
  be/gcc
  lilian/perl
  lilian/pkg-config
  lilian/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/harfbuzz)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

source ../defaults.sh

do_build() {
  ./configure --prefix="$pkg_prefix" \
              --with-gobject=yes

  make -j "$(nproc)"
}

do_install() {
  make -j "$(nproc)" install
}

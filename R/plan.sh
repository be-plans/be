pkg_name=R
pkg_origin=lilian
pkg_version="3.4.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0+')
pkg_source="https://cran.r-project.org/src/base/R-3/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="288e9ed42457c47720780433b3d5c3c20983048b789291cc6a7baa11f9428b91"
pkg_upstream_url="https://www.r-project.org"
pkg_description="R is a free software environment for statistical computing and graphics."
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/file
  lilian/gcc
  lilian/make
  lilian/perl
  lilian/pkg-config
  lilian/texinfo
)
pkg_deps=(
  lilian/bzip2
  lilian/cairo
  lilian/curl
  lilian/harfbuzz
  lilian/icu
  lilian/expat
  lilian/fontconfig
  lilian/freetype
  lilian/glib
  lilian/libjpeg-turbo
  lilian/liberation-fonts-ttf
  lilian/libpng
  lilian/libtiff
  lilian/pango
  lilian/pcre
  lilian/pixman
  lilian/readline
  lilian/xz
  lilian/zlib
)
pkg_bin_dirs=(lib64/R/bin)
pkg_include_dirs=(lib64/R/include)
pkg_lib_dirs=(lib64/R/lib)

source ../defaults.sh

do_build() {
    sed -i '/#include.*<cairo-xlib.h>/d' ./configure
    ./configure \
      --prefix="${pkg_prefix}" \
		  --with-x=no \
      --disable-java \
	    --enable-memory-profiling

    make -j "$(nproc)"
}

do_check() {
    make test
}

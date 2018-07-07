pkg_name=R
pkg_origin=core
pkg_version="3.5.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0+')
pkg_source="https://cran.r-project.org/src/base/R-3/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="fd1725535e21797d3d9fea8963d99be0ba4c3aecadcf081b43e261458b416870"
pkg_upstream_url="https://www.r-project.org"
pkg_description="R is a free software environment for statistical computing and graphics."
pkg_build_deps=(
  be/coreutils
  be/diffutils
  be/file
  be/gcc
  be/make
  be/perl
  be/pkg-config
  be/texinfo
)
pkg_deps=(
  be/bzip2
  lilian/cairo
  be/curl
  be/gcc
  lilian/harfbuzz
  lilian/icu
  be/expat
  lilian/fontconfig
  lilian/freetype
  lilian/glib
  lilian/libjpeg-turbo
  lilian/liberation-fonts-ttf
  lilian/libpng
  lilian/libtiff
  lilian/pango
  be/pcre
  lilian/pixman
  be/readline
  be/xz
  be/zlib
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

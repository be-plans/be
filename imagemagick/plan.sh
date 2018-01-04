pkg_name=imagemagick
pkg_origin=core
pkg_version=7.0.5-10
pkg_description="A software suite to create, edit, compose, or convert bitmap images."
pkg_upstream_url="http://imagemagick.org/"
pkg_license=('Apache2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://www.imagemagick.org/download/releases/ImageMagick-${pkg_version}.tar.xz
pkg_shasum=0058fcde533986334458a5c99600b1b9633182dd9562cbad4ba618c5ccf2a28f
pkg_deps=(
    core/glibc core/gcc-libs
    be/zlib lilian/libpng be/xz
)
pkg_build_deps=(
  be/zlib be/coreutils be/diffutils
  be/patch be/make be/gcc
  be/sed core/glibc be/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/ImageMagick-7)
pkg_lib_dirs=(lib)
pkg_dirname=ImageMagick-${pkg_version}

source ../defaults.sh

do_build() {
    CC="gcc -std=gnu99" ./configure --prefix=$pkg_prefix
    make -j $(nproc)
}

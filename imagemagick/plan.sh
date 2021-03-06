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
    core/glibc lilian/gcc-libs
    lilian/zlib lilian/libpng lilian/xz
)
pkg_build_deps=(
  lilian/zlib lilian/coreutils lilian/diffutils
  lilian/patch lilian/make lilian/gcc
  lilian/sed core/glibc lilian/pkg-config
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

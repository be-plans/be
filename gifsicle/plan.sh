pkg_name=gifsicle
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_origin=core
pkg_version=1.88
pkg_license=('GPLv2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.lcdf.org/gifsicle/gifsicle-${pkg_version}.tar.gz
pkg_shasum=4585d2e683d7f68eb8fcb15504732d71d7ede48ab5963e61915201f9e68305be
pkg_bin_dirs=(bin)
pkg_deps=(lilian/zlib core/glibc)
pkg_build_deps=(lilian/zlib lilian/coreutils lilian/diffutils lilian/patch lilian/make lilian/gcc lilian/sed core/glibc)

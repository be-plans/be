pkg_name=linux-headers-musl
pkg_origin=core
pkg_version=3.12.6-5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Linux kernel headers (sanitized for use with musl)."
pkg_upstream_url="https://github.com/sabotage-linux/kernel-headers"
pkg_license=('MIT')
pkg_source="https://github.com/sabotage-linux/kernel-headers/archive/v${pkg_version}.tar.gz"
pkg_shasum="ecf4db8781dc50a21cbc4cb17b039f96aede53f9da13435a3201373abb49b96b"
pkg_dirname="kernel-headers-${pkg_version}"
pkg_deps=()
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/gcc
  lilian/make
  lilian/patch
)
pkg_include_dirs=(include)

pkg_disabled_features=(glibc)
source ../defaults.sh

do_build() {
  make -j "$(nproc)" \
    ARCH=x86_64 \
    prefix="${pkg_prefix}"
}

do_install() {
  make -j "$(nproc)" \
    ARCH=x86_64 \
    prefix="${pkg_prefix}" \
    install
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    lilian/gcc/7.1.0/20170624225400
    lilian/coreutils/8.27/20170624233515
    lilian/diffutils/3.6/20170624234540
    lilian/make/4.2.1/20170624234911
    lilian/patch/2.7.5/20170624234926
  )
fi

pkg_name=iana-etc
pkg_origin=lilian
pkg_version=2.30
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source=http://sethwklein.net/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=b9a6874fb20012836efef75452ef2acae624022d680feeb1994d73facba3f20d
pkg_deps=()
pkg_build_deps=(lilian/coreutils lilian/make lilian/gawk)

source ../better_defaults.sh

do_build() {
  make -j $(nproc)
}

do_install() {
  make -j $(nproc) install PREFIX="${pkg_prefix}"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(lilian/coreutils lilian/gawk)
fi

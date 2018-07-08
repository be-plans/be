source ../libsodium/plan.sh

pkg_name=libsodium-musl
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Sodium is a new, easy-to-use software library for encryption, decryption, \
signatures, password hashing and more. It is a portable, cross-compilable, \
installable, packageable fork of NaCl, with a compatible API, and an extended \
API to improve usability even further.\
"
pkg_upstream_url="https://github.com/jedisct1/libsodium"
pkg_license=('libsodium')
pkg_deps=(
  be/musl
)

pkg_disabled_features=(glibc)
source ../defaults.sh

do_prepare() {
  do_default_prepare

  export CC=musl-gcc
  build_line "Setting CC=$CC"
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
    lilian/sed/4.4/20170624233625
    lilian/diffutils/3.6/20170624234540
    lilian/make/4.2.1/20170624234911
  )
fi

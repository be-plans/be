pkg_name=musl
pkg_origin=core
pkg_version=1.1.19
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
musl is a new standard library to power a new generation of Linux-based \
devices. musl is lightweight, fast, simple, free, and strives to be correct \
in the sense of standards-conformance and safety.\
"
pkg_upstream_url="https://www.musl-libc.org/"
pkg_license=('MIT')
pkg_source="http://www.musl-libc.org/releases/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="db59a8578226b98373f5b27e61f0dd29ad2456f4aa9cec587ba8c24508e4c1d9"
pkg_deps=()
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/gcc
  lilian/make
  lilian/patch
  lilian/sed
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_disabled_features=(glibc)
source ../defaults.sh

do_prepare() {
  do_default_prepare

  stack_size="2097152"
  build_line "Setting default stack size to '$stack_size' from default '81920'"
  sed \
    -i "s/#define DEFAULT_STACK_SIZE .*/#define DEFAULT_STACK_SIZE $stack_size/" \
    src/internal/pthread_impl.h

}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --syslibdir="$pkg_prefix/lib"

  make -j "$(nproc)"
}

do_install() {
  do_default_install

  # Install license
  install -Dm0644 COPYRIGHT "$pkg_prefix/share/licenses/COPYRIGHT"
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
    lilian/patch/2.7.5/20170624234926
  )
fi

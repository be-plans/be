pkg_name=expect
pkg_origin=core
pkg_version=5.45.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Expect is a tool for automating interactive applications such as telnet, ftp, \
passwd, fsck, rlogin, tip, etc. Expect really makes this stuff trivial. Expect \
is also useful for testing these same applications.\
"
pkg_upstream_url="https://www.nist.gov/services-resources/software/expect"
pkg_license=('custom')
pkg_source="http://downloads.sourceforge.net/project/$pkg_name/Expect/${pkg_version}/${pkg_name}${pkg_version}.tar.gz"
pkg_shasum="49a7da83b0bdd9f46d04a04deec19c7767bb9a323e40c4781f89caf760b92c34"
pkg_dirname=${pkg_name}${pkg_version}
pkg_deps=(
  lilian/gcc-libs
  core/glibc
  lilian/tcl
  lilian/zlib
)
pkg_build_deps=(
  lilian/coreutils
  lilian/diffutils
  lilian/gcc
  lilian/make
  lilian/patch
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_disabled_features=(pic)
source ../defaults.sh

do_prepare() {
  do_default_prepare

  # Make the path to `stty` absolute from `coreutils`
  sed -i "s,/bin/stty,$(pkg_path_for coreutils)/bin/stty,g" configure
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --exec-prefix="$pkg_prefix" \
    --with-tcl="$(pkg_path_for tcl)/lib" \
    --with-tclinclude="$(pkg_path_for tcl)/include"

  make -j "$(nproc)"
}

do_check() {
  make test
}

do_install() {
  make -j "$(nproc)" install

  # Add an absolute path to `tclsh` in each script binary
  find "$pkg_prefix/bin" \
    -type f \
    -exec sed -e "s,exec tclsh,exec $(pkg_path_for tcl)/bin/tclsh,g" -i {} \;
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

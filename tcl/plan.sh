pkg_name=tcl
pkg_origin=core
pkg_version=8.6.4
pkg_license=('custom')
pkg_description="Tool Command Language -- A dynamic programming language."
pkg_upstream_url="http://www.tcl.tk/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://downloads.sourceforge.net/sourceforge/${pkg_name}/${pkg_name}${pkg_version}-src.tar.gz
pkg_shasum=9e6ed94c981c1d0c5f5fefb8112d06c6bf4d050a7327e95e71d417c416519c8d
pkg_dirname=${pkg_name}${pkg_version}
pkg_deps=(core/glibc core/gcc-libs lilian/zlib)
pkg_build_deps=(be/coreutils be/diffutils be/patch be/make be/gcc be/sed)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

no_pie=true
source ../defaults.sh

do_build() {
  pushd unix > /dev/null
    export LDFLAGS="-lgcc_s ${LDFLAGS}"
    ./configure \
      --prefix="$pkg_prefix" \
      --enable-threads \
      --enable-64bit
    make -j "$(nproc)"

    # The Tcl package expects that its source tree is preserved so that
    # packages depending on it for their compilation can utilize it. These sed
    # remove the references to the build directory and replace them with more
    # reasonable system-wide locations.
    #
    # Thanks to: http://www.linuxfromscratch.org/blfs/view/stable/general/tcl.html
    # Thanks to: https://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/tcl
    local srcdir
    srcdir=$(abspath ..)
    local tdbcver=tdbc1.0.3
    local itclver=itcl4.0.3
    sed \
      -e "s#$srcdir/unix#$pkg_prefix/lib#" \
      -e "s#$srcdir#$pkg_prefix/include#" \
      -i tclConfig.sh
    sed \
      -e "s#$srcdir/unix/pkgs/$tdbcver#$pkg_prefix/lib/$tdbcver#" \
      -e "s#$srcdir/pkgs/$tdbcver/generic#$pkg_prefix/include#" \
      -e "s#$srcdir/pkgs/$tdbcver/library#$pkg_prefix/lib/tcl${pkg_version%.?}#" \
      -e "s#$srcdir/pkgs/$tdbcver#$pkg_prefix/include#" \
      -i pkgs/$tdbcver/tdbcConfig.sh
    sed \
      -e "s#$srcdir/unix/pkgs/$itclver#$pkg_prefix/lib/$itclver#" \
      -e "s#$srcdir/pkgs/$itclver/generic#$pkg_prefix/include#" \
      -e "s#$srcdir/pkgs/$itclver#$pkg_prefix/include#" \
      -i pkgs/itcl4.0.3/itclConfig.sh
  popd > /dev/null
}

do_install() {
  pushd unix > /dev/null
    make -j "$(nproc)" install
    make -j "$(nproc)" install-private-headers

    # Many packages expect a file named tclsh, so create a symlink
    ln -sfv "tclsh${pkg_version%.?}" "$pkg_prefix/bin/tclsh"

    chmod -v 755 "$pkg_prefix/lib/libtcl${pkg_version%.?}.so"
    ln -sfv "libtcl${pkg_version%.?}.so" "$pkg_prefix/lib/libtcl.so"

    # Install license file
    install -Dm644 ../license.terms "${pkg_prefix}/share/licenses/LICENSE"
  popd > /dev/null
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(be/gcc be/coreutils be/sed be/diffutils be/make be/patch)
fi

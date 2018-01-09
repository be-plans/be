pkg_name=busybox
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=1.26.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source=http://www.busybox.net/downloads/${pkg_distname}-${pkg_version}.tar.bz2
pkg_shasum=da3e44913fc1a9c9b7c5337ea5292da518683cbff32be630777f565d6036af16

pkg_deps=(core/glibc)
pkg_build_deps=(
  be/bash
  be/bison
  be/coreutils
  be/diffutils
  be/findutils
  be/flex
  be/gawk
  be/gcc
  be/gettext
  be/grep
  be/gzip
  be/libtool
  be/make
  be/patch
  be/sed
  be/texinfo
  be/util-linux
  be/wget
  be/xz
)

pkg_bin_dirs=(bin)
pkg_interpreters=(bin/ash bin/awk bin/env bin/sh bin/bash)

source ../defaults.sh

do_prepare() {
  do_default_prepare
  be_remove_compiler_flag "-D_GNU_SOURCE"
  create_config
}

do_build() {
  make -j $(nproc)
}

do_install() {
  install -Dm755 busybox $pkg_prefix/bin/busybox

  # Generate the symlinks back to the `busybox` executable
  for l in $($pkg_prefix/bin/busybox --list); do
    ln -sv busybox $pkg_prefix/bin/$l
  done
}

create_config() {
  # To update to a new version, run `make defconfig` to generate a new
  # `.config` file and add the following replacement tokens below.
  build_line "Customizing busybox configuration..."
  cat $PLAN_CONTEXT/config \
    | sed \
      -e "s,@pkg_prefix@,$pkg_prefix,g" \
      -e "s,@pkg_svc_var@,$pkg_svc_var_path,g" \
      -e "s,@cflags@,$CFLAGS,g" \
      -e "s,@ldflags@,$LDFLAGS,g" \
      -e "s,@osname@,Habitat,g" \
      -e "s,@bash_is_ash@,y,g" \
    > .config
}

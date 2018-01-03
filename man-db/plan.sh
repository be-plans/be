pkg_origin=core
pkg_name=man-db
pkg_version=2.7.6.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_description="man-db is an implementation of the standard Unix documentation system accessed using the man command."
pkg_upstream_url=http://man-db.nongnu.org/
pkg_source="http://git.savannah.gnu.org/cgit/man-db.git/snapshot/man-db-${pkg_version}.tar.gz"
pkg_shasum=dd913662e341fc01e6721878b6cbe1001886cc3bfa6632b095937bba3238c779
pkg_deps=(
  lilian/gdbm
  core/glibc
  lilian/groff
  lilian/gzip
  lilian/libiconv
)
pkg_build_deps=(
  be/coreutils
  be/diffutils
  lilian/flex
  be/gcc
  lilian/gettext
  lilian/libpipeline
  be/make
  lilian/m4
  lilian/pkg-config
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib/man-db)

source ../defaults.sh

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --disable-setuid \
    --disable-silent-rules \
    --enable-automatic-create \
    --enable-mandirs=GNU \
    --enable-threads=posix \
    --enable-mb-groff \
    --with-gzip="$(pkg_path_for gzip)/bin/gzip" \
    --with-libiconv-prefix="$(pkg_path_for libiconv)" \
    --with-systemdtmpfilesdir="${pkg_svc_config_path}/tmpfiles.d"

  make -j $(nproc)
}

do_prepare() {
  do_default_prepare
  # /var/cache/man is hard-coded in a few places. We should replace this with
  # /hab/svc/man-db/var/cache/man. Since man-db isn't run as a service, this
  # directory won't actually exist unless created manually, but it will keep us out
  # of the filesystem and in the /hab directory.
  #
  # The file that gets generated here gets written to
  # $pkg_prefix/etc/man_db.conf.
  sed -i -e "s#/var/#$pkg_svc_var_path/#g" "$CACHE_PATH/src/man_db.conf.in"
}

do_check() {
  make check
}

do_install() {
  do_default_install

  # Removing reference to non-existent user(--disable-setuid), inspired from Linux From Scratch:
  # http://www.linuxfromscratch.org/lfs/view/development/chapter06/man-db.html
  sed -i "s:man root:root root:g" "${pkg_svc_config_path}/tmpfiles.d/man-db.conf"
}

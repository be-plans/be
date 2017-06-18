pkg_name=jfrog-cli
pkg_description="jfrog CLI"
pkg_origin=lilian
pkg_version=1.9.0
pkg_license=('apachev2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://github.com/JFrogDev/jfrog-cli-go"
pkg_source=https://jfrog.bintray.com/jfrog-cli-go/${pkg_version}/jfrog-cli-linux-amd64/jfrog
pkg_shasum=4ec5550aee278386ab9ebbcdf95fb14b2ce82a0979d66cba92fdcea97f9aaa0f
pkg_deps=(lilian/glibc core/busybox-static lilian/cacerts)
pkg_build_deps=(lilian/coreutils)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  install -D "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/jfrog"
  cgo_wrap_binary jfrog
}

cgo_wrap_binary() {
  local bin="$pkg_prefix/bin/$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  local certs
  certs="$(pkg_path_for cacerts)/ssl/cert.pem"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
if [ ! -f "/etc/ssl/certs/ca-certificates.crt" ]; then
  echo "Adding symlink of $certs under /etc"
  mkdir -p /etc/ssl/certs
  ln -snf $certs /etc/ssl/certs/ca-certificates.crt
fi
export LD_LIBRARY_PATH="$LD_RUN_PATH"
exec $(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2 ${bin}.real \$@
EOF
  chmod -v 755 "$bin"
}

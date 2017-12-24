pkg_name=terraform
pkg_origin=be
pkg_version=0.10.2
pkg_license=('MPL-2.0')
pkg_description="Terraform is a tool for building, changing, and combining infrastructure safely and efficiently"
pkg_upstream_url="http://www.terraform.io/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_filename=${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=6c1b5ce1a78bc7bb895055052d9074e519f51293770871acfe2dbd289e2f2aaa
pkg_build_deps=(lilian/unzip)
pkg_deps=()
pkg_bin_dirs=(bin)

source ../defaults.sh

# The pkg_filename does not extract into a folder. We need to force it.
do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip ${pkg_filename} -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D terraform "${pkg_prefix}/bin/terraform"
}

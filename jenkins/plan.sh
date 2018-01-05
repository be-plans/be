pkg_name=jenkins
pkg_origin=core
pkg_version=2.89.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The leading open source automation server, Jenkins provides hundreds of plugins to support building, deploying and automating any project."
pkg_license=('mit')
pkg_upstream_url="https://jenkins.io/"
pkg_source="http://mirrors.jenkins.io/war-stable/${pkg_version}/jenkins.war"
pkg_shasum="014f669f32bc6e925e926e260503670b32662f006799b133a031a70a794c8a14"
pkg_deps=(lilian/jre8 be/curl)
pkg_exports=(
  [port]=jenkins.http.port
)
pkg_exposes=(port)
pkg_svc_user="root"

source ../defaults.sh

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  cp "${HAB_CACHE_SRC_PATH}"/"${pkg_filename}" "${pkg_prefix}"/jenkins.war
}

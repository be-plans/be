#! /bin/bash

error() {
  local -r message="${1:?}"
  echo "${message}"
  exit 1
}

check_prerequisites() {
  check() {
    test -z "$(which "${1:?}")" && error "Could not find tool: \"${1}\""
  }

  test -z "$(which which)" && error "Could not find tool: \"which\""

  check "wget"
  check "sha256sum"
  check "mktemp"
}

generate_plan() {
  local -r pkg_source="${1:?}"
  printf "Please insert the pkg_name: "
  read pkg_name

  test -d "${pkg_name}" && error "The directory for pkg_name: \"${pkg_name}\" already exists"
  mkdir -p "${pkg_name}"
  cd "${pkg_name}"

  local compression_type
  local -r compression_types=('tar' 'tar.bz2' 'tar.gz' 'tar.xz' 'rar' 'zip' 'Z' '7z')
  for type in "${compression_types[@]}"; do
    test -n "$(echo "${pkg_source}" | grep -E "\.${type}$")" \
    && compression_type="${type}" && break
  done

  local -r empty="[empty]"
  local pkg_version="$(echo "${pkg_source}" | grep -E "([0-9]+\.)+([0-9])+\.${compression_type}$" -o)"
  pkg_version="$(echo ${pkg_version} | grep -E "([0-9]+\.)+([0-9])+" -o)"
  test -z "${pkg_version}" && pkg_version="${empty:?}"

  local modified_pkg_source="$(echo "${pkg_source}" | sed "s|${pkg_name}|\${pkg_name}|g")"
  modified_pkg_source="$(echo "${modified_pkg_source}" | sed "s|${pkg_version}|\${pkg_version}|g")"

  echo "Calculating sha256sum of the archive"
  local -r temp_dir="$(mktemp -d)" # we will store copied pkg_source here
  pushd "${temp_dir:?}" || error "Could not move into: ${temp_dir}"
  wget "${pkg_source}" # we will calculate sha256 on this file
  local -r sha256="$(sha256sum * | cut -d ' ' -f 1)"
  popd
  rm -rf "${temp_dir}" # cleanup

  echo "pkg_origin=core
pkg_name=${pkg_name}
pkg_version=${pkg_version}
pkg_maintainer=\"The Habitat Maintainers <humans@habitat.sh>\"
pkg_license=('${empty}')
pkg_description=\"${empty}\"
pkg_upstream_url=${empty}
pkg_source=${modified_pkg_source:?}
pkg_shasum=${sha256:?}
pkg_deps=(
  core/glibc
)
pkg_build_deps=(

)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

source ../defaults.sh" > plan.sh

  cd ..
  echo "Plan(template) \"${pkg_name}\" was created"
}

main() {
  test -z "${1}" && error "Please pass in the link to archive"
  check_prerequisites
  generate_plan "${1}"
}

main "$@"

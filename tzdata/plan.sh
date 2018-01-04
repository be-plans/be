pkg_name=tzdata
pkg_origin=core
pkg_version=2017c
pkg_description="Sources for time zone and daylight saving time data"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source=http://download.openpkg.org/components/cache/data-timezone/${pkg_name}${pkg_version}.tar.gz
pkg_shasum=d6543f92a929826318e2f44ff3a7611ce5f565a43e10250b42599d0ba4cbd90b
pkg_upstream_url=https://www.iana.org/time-zones

pkg_build_deps=(be/glibc)

timezones=(
  'africa'
  'antarctica'
  'asia'
  'australasia'
  'europe'
  'northamerica'
  'southamerica'
  'pacificnew'
  'etcetera'
  'backward'
  'systemv'
  'factory'
)

do_unpack() {
  mkdir -p "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname" > /dev/null
    tar xf "$HAB_CACHE_SRC_PATH/$pkg_filename"
  popd > /dev/null
}

do_build() {
  return 0
}

do_install() {
  zic -y ./yearistype -d "$pkg_prefix/share/zoneinfo" "${timezones[@]}"
  zic -y ./yearistype -d "$pkg_prefix/share/zoneinfo/posix" "${timezones[@]}"
  zic -y ./yearistype -d "$pkg_prefix/share/zoneinfo/right" -L leapseconds "${timezones[@]}"

  zic -y ./yearistype -d "$pkg_prefix/share/zoneinfo" -p America/New_York
  install -m444 -t "$pkg_prefix/share/zoneinfo" -v iso3166.tab zone1970.tab zone.tab
}

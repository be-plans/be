pkg_origin=lilian
pkg_name=icu
pkg_version=57.1
pkg_description="$(cat << EOF
  ICU is a mature, widely used set of C/C++ and Java libraries providing
  Unicode and Globalization support for software applications. ICU is widely
  portable and gives applications the same results on all platforms and
  between C/C++ and Java software.
EOF
)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Unicode-TOU")
# shellcheck disable=SC2059
pkg_source="http://download.icu-project.org/files/icu4c/${pkg_version}/icu4c-$(printf "%s" "$pkg_version" | tr . _)-src.tgz"
pkg_shasum=ff8c67cb65949b1e7808f2359f2b80f722697048e90e7cfc382ec1fe229e9581
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=icu/source

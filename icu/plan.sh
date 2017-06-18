pkg_origin=lilian
pkg_name=icu
pkg_version=59.1
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
pkg_shasum=7132fdaf9379429d004005217f10e00b7d2319d0fea22bdfddef8991c45b75fe
pkg_deps=(lilian/glibc lilian/gcc-libs)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=icu/source

source ../defaults.sh

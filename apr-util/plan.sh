pkg_name=apr-util
pkg_origin=lilian
pkg_version=1.5.4
pkg_license=('Apache2')
pkg_source=http://www.us.apache.org/dist/apr/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=a6cf327189ca0df2fb9d5633d7326c460fe2b61684745fd7963e79a6dd0dc82e
pkg_deps=(core/glibc core/apr)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)

compiler_flags() {
  local -r optimizations="-O2 -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
  local -r protection="-fstack-protector-strong -Wformat -Werror=format-security"
  export CFLAGS="${CFLAGS} -std=c11 ${optimizations} ${protection} "
  export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_prepare() {
	do_default_prepare
	compiler_flags
}

do_build() {
	./configure --prefix=${pkg_prefix} --with-apr=$(pkg_path_for core/apr)
	make
}

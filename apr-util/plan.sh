pkg_name=apr-util
pkg_origin=lilian
pkg_version=1.5.4
pkg_license=('Apache2')
pkg_source=http://www.us.apache.org/dist/apr/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=a6cf327189ca0df2fb9d5633d7326c460fe2b61684745fd7963e79a6dd0dc82e
pkg_deps=(lilian/glibc lilian/apr)
pkg_build_deps=(lilian/gcc lilian/make)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
	./configure --prefix=${pkg_prefix} --with-apr=$(pkg_path_for lilian/apr)
	make -j $(nproc)
}

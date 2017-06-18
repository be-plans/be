pkg_name=pv
pkg_origin=lilian
pkg_license=('ARTISTIC 2.0')
pkg_version="1.6.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline."
pkg_upstream_url="http://www.ivarch.com/programs/pv.shtml"
pkg_source="https://www.ivarch.com/programs/sources/pv-${pkg_version}.tar.bz2"
pkg_shasum="0ece824e0da27b384d11d1de371f20cafac465e038041adab57fcf4b5036ef8d"
pkg_deps=(lilian/glibc)
pkg_build_deps=(lilian/make lilian/gcc)
pkg_bin_dirs=(bin)

source ../defaults.sh

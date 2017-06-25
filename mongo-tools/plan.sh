pkg_name=mongo-tools
pkg_origin=lilian
pkg_version=3.5.8
pkg_description="MongoDB Tools"
pkg_upstream_url=https://github.com/mongodb/mongo-tools
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/mongodb/mongo-tools/archive/r${pkg_version}.tar.gz
pkg_shasum=4756d391d2b5391b0fb3adcdb3b4ef7538c2b04e643086010ca772fdf0caf293
pkg_dirname=${pkg_name}-r${pkg_version}
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(core/glibc)
pkg_build_deps=(lilian/go lilian/coreutils lilian/gcc lilian/make)
pkg_bin_dirs=(bin)

source ../defaults.sh

do_build() {
  ./set_gopath.sh
  export GOPATH=/hab/cache/src/mongo-tools-r${pkg_version}/.gopath:/hab/cache/src/mongo-tools-r${pkg_version}/vendor
  for i in mongodump mongoexport mongofiles mongoimport mongooplog mongorestore mongostat mongotop; do
    go build -o bin/$i $i/main/$i.go
  done
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp bin/* "${pkg_prefix}/bin"
}

pkg_name=mongodb
pkg_origin=lilian
pkg_version=3.2.13
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_source=http://downloads.mongodb.org/src/${pkg_name}-src-r${pkg_version}.tar.gz
pkg_shasum=31492b99d12d6363a6ebcbba32269ce9e97dadedda8c470cbff8c1af227e9753
pkg_upstream_url=https://www.mongodb.com/
pkg_filename=${pkg_name}-src-r${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-src-r${pkg_version}
pkg_deps=(core/gcc-libs core/glibc lilian/openssl )
pkg_build_deps=(
  lilian/coreutils
  core/gcc
  core/glibc
  lilian/python2
  lilian/scons
  lilian/openssl
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_svc_run="mongod --config $pkg_svc_config_path/mongod.conf"
pkg_svc_user=hab
pkg_svc_group=hab
pkg_exports=(
  [port]=mongod.net.port
)
pkg_exposes=(port)

# _compiler_flags() {
# #   local -r optimizations="-O2 -DNDEBUG -fomit-frame-pointer -mavx -march=corei7-avx -mtune=corei7-avx"
#   local -r protection="-fstack-protector-strong"
#   export CFLAGS="${CFLAGS} ${optimizations} ${protection} -Wno-error "
#   export CXXFLAGS="${CXXFLAGS} -std=c++14 ${optimizations} ${protection} -Wno-error "
#   export CPPFLAGS="${CPPFLAGS} -Wno-error "
#   export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
# }

# do_default_prepare() {
#   _compiler_flags
# }

do_prepare() {
    # do_default_prepare

    CC="$(pkg_path_for core/gcc)/bin/gcc"
    CXX="$(pkg_path_for core/gcc)/bin/g++"
    export CC
    export CXX

    # create variables for our include and library pathes in a scons friendly format
    # shellcheck disable=SC2001
    INCPATH="$(echo "${CFLAGS}" | sed -e "s@-I@@g")"
    # shellcheck disable=SC2001
    INCPATH="$(echo "${INCPATH}" | sed -e "s@ @', '@g")"
    # shellcheck disable=SC2001
    LIBPATH="$(echo "${LDFLAGS}" | sed -e "s@-L@@g")"
    # shellcheck disable=SC2001
    LIBPATH="$(echo "${LIBPATH}" | sed -e "s@ @', '@g")"
    export LIBPATH
    export INCPATH

    # because scons dislikes saving our variables, we will save our
    # variables within the construct ourselves
    sed -i "836s@**envDict@ENV = os.environ, CPPPATH = ['$INCPATH'], LIBPATH = ['$LIBPATH'], CFLAGS = os.environ['CFLAGS'], CXXFLAGS = os.environ['CXXFLAGS'], LINKFLAGS = os.environ['LDFLAGS'], CC = os.environ['CC'], CXX = os.environ['CXX'], PATH = os.environ['PATH'], **envDict@g" SConstruct
}

do_build() {
    scons core --prefix="$pkg_prefix" --ssl -j"$(nproc)"
}

do_install() {
    scons install --prefix="$pkg_prefix" --ssl
}

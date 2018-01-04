source ../jre8/plan.sh

pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_name=jre9
pkg_version=9.0.1
pkg_source=http://download.oracle.com/otn-pub/java/jdk/${pkg_version}+11/jre-${pkg_version}_linux-x64_bin.tar.gz
pkg_shasum=3c64953465e98dbab0e449954a918fada703cd0341aa98cff68854852663ee86
pkg_filename=jre-${pkg_version}-linux-x64_bin.tar.gz
pkg_license=('Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX')
pkg_description=('Oracle Java Runtime Environment. This package is made available to you to allow you to run your applications as provided in and subject to the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html')
pkg_upstream_url=http://www.oracle.com/technetwork/java/javase/overview/index.html
pkg_deps=(core/glibc core/gcc-libs core/xlib core/libxi core/libxext core/libxrender core/libxtst be/zlib)
pkg_build_deps=(be/patchelf)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}

do_setup_environment() {
 set_runtime_env JAVA_HOME "$pkg_prefix"
}

# Most steps sourced from ../jre8/plan.sh

do_install() {
  cd "$source_dir" || exit
  cp -r ./* "$pkg_prefix"

  build_line "Setting interpreter for '${pkg_prefix}/bin/java' '$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2'"
  build_line "Setting rpath for '${pkg_prefix}/bin/java' to '$LD_RUN_PATH'"

  export LD_RUN_PATH=$LD_RUN_PATH:$pkg_prefix/lib/jli:$pkg_prefix/lib/server:$pkg_prefix/lib

  find "$pkg_prefix"/bin -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  find "$pkg_prefix/lib" -type f -name "*.so" \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
}

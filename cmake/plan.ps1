$pkg_name="cmake"
$pkg_origin="core"
$base_version="3.10"
$pkg_version="$base_version.1"
$pkg_description="CMake is an open-source, cross-platform family of tools designed to build, test and package software"
$pkg_upstream_url="https://cmake.org/"
$pkg_license=@("BSD-3-Clause")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="http://cmake.org/files/v$base_version/cmake-$pkg_version-win64-x64.msi"
$pkg_shasum="23fe84a5cec997e1b8a7725713cf8b0934071f5b25b53c51acf51490dff4e468"
$pkg_build_deps=@("lilian/lessmsi")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
  mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  Move-Item "cmake-$pkg_version-win64-x64/SourceDir/cmake" "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/cmake/*" "$pkg_prefix" -Recurse -Force
}

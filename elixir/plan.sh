pkg_origin=lilian
pkg_name=elixir
pkg_version=1.4.4
pkg_description="A dynamic, functional language designed for building scalable and maintainable applications. Elixir leverages the Erlang VM, known for running low-latency, distributed and fault-tolerant systems, while also being successfully used in web development and the embedded software domain."
pkg_upstream_url=http://elixir-lang.org
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/elixir-lang/elixir/archive/v${pkg_version}.tar.gz"
pkg_shasum=2d9d5faee079949f780c8f6a1ccba015d64ecf859ed87384ae4239d69be60142
pkg_deps=(
  lilian/busybox lilian/cacerts lilian/coreutils
  lilian/openssl lilian/erlang
)
pkg_build_deps=(
  lilian/busybox lilian/cacerts lilian/coreutils
  lilian/make lilian/openssl lilian/erlang
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

source ../defaults.sh

do_prepare() {
    localedef -i en_US -f UTF-8 en_US.UTF-8
    export LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
}

do_build() {
    fix_interpreter "rebar" lilian/coreutils bin/env
    fix_interpreter "rebar3" lilian/coreutils bin/env
    fix_interpreter "bin/*" lilian/coreutils bin/env
    make -j "$(nproc)"
}

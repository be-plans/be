pkg_name=postfix
pkg_origin=core
pkg_version="3.2.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Postfix is a free and open-source mail transfer agent that routes and delivers electronic mail."
pkg_upstream_url="http://www.postfix.org/"
pkg_license=('IPL-1.0')
pkg_source="http://cdn.postfix.johnriley.me/mirrors/${pkg_name}-release/official/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="ec55ebaa2aa464792af8d5ee103eb68b27a42dc2b36a02fee42dafbf9740c7f6"

pkg_build_deps=(
  lilian/make
  lilian/gcc
  lilian/sed
  lilian/gawk
)

pkg_deps=(
  # postfix deps
  lilian/coreutils
  lilian/cyrus-sasl
  lilian/db
  core/glibc
  lilian/libnsl
  lilian/openssl
  lilian/pcre
  lilian/zlib

  # plan/hook deps
  lilian/shadow
  lilian/iana-etc
)

pkg_bin_dirs=(bin sbin)

pkg_svc_user=root


do_build() {
  POSTFIX_CCARGS=(
    -DHAS_DB
      -I$(pkg_path_for db)/include
    -DHAS_NIS
      -I$(pkg_path_for lilian/libnsl)/include
    -DUSE_TLS
      -I$(pkg_path_for lilian/openssl)/include
    -DUSE_SASL_AUTH -DUSE_CYRUS_SASL
      -I$(pkg_path_for lilian/cyrus-sasl)/include/sasl
  )
  build_line "Setting POSTFIX_CCARGS=${POSTFIX_CCARGS[*]}"

  POSTFIX_AUXLIBS=(
    -ldb
      -L$(pkg_path_for lilian/db)/lib
    -lnsl
      -L$(pkg_path_for lilian/libnsl)/lib
    -lresolv
      -L$(pkg_path_for core/glibc)/lib
    -lssl -lcrypto
      -L$(pkg_path_for lilian/openssl)/lib
    -lsasl2
      -L$(pkg_path_for lilian/cyrus-sasl)/lib
  )
  build_line "Setting POSTFIX_AUXLIBS=${POSTFIX_AUXLIBS[*]}"

  make makefiles CCARGS="${POSTFIX_CCARGS[*]}" AUXLIBS="${POSTFIX_AUXLIBS[*]}"
  make
}

do_install() {

  # because postfix-install ignores PATH
  hab pkg binlink lilian/coreutils -d /bin uname
  hab pkg binlink lilian/coreutils -d /bin rm
  hab pkg binlink lilian/coreutils -d /bin touch
  hab pkg binlink lilian/coreutils -d /bin mkdir
  hab pkg binlink lilian/coreutils -d /bin chmod
  hab pkg binlink lilian/coreutils -d /bin cp
  hab pkg binlink lilian/coreutils -d /bin mv
  hab pkg binlink lilian/coreutils -d /bin ln
  hab pkg binlink lilian/sed -d /bin sed
  hab pkg binlink lilian/gawk -d /bin awk


  make non-interactive-package \
    install_root="${pkg_prefix}" \
    daemon_directory="/sbin" \
    command_directory="/bin" \
    mailq_path="/bin/mailq" \
    sendmail_path="/bin/sendmail" \
    newaliases_path="/bin/newaliases" \
    shlib_directory="/lib" \
    meta_directory="/meta" \
    manpage_directory="/man" \
    config_directory="/config" \
    data_directory="/data/postfix" \
    mail_spool_directory="/data/spool" \
    queue_directory="/data/queue"

  # delete .default files that contain template-looking syntax
  rm "${pkg_prefix}/config/main.cf.default"
}

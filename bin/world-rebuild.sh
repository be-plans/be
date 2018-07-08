#! /usr/bin/env bash

# Run this script outside a studio environment, from "be"(project) root directory

__build_base_plans() {
  sudo hab studio rm
  sudo hab studio new
  sudo hab studio run 'hab pkg install lilian/bash/4.3.42/20170624233914'
  sudo hab studio run 'hab pkg install lilian/coreutils/8.27/20170624233515'
  sudo hab studio run 'hab pkg install lilian/file/5.31/20170625112308'
  sudo hab studio run 'hab pkg binlink --dest /bin lilian/bash/4.3.42/20170624233914'
  sudo hab studio run 'hab pkg binlink --dest /usr/bin lilian/coreutils/8.27/20170624233515'
  sudo hab studio run 'hab pkg binlink --dest /usr/bin lilian/file/5.31/20170625112308'
  sudo hab studio run 'ln -s /src /be'
  sudo hab studio run 'cd / && /lilian/bin/build-plans.sh lilian/base-plans.txt'
}

main() {
  if [ ! -e "bin/build-plans.sh" ]; then
    echo "Please execute the script from the project root directory"
    exit 1
  fi

  export STUDIO_TYPE=stage1
  export NO_INSTALL_DEPS=true
  __build_base_plans

  unset STUDIO_TYPE
  __build_base_plans
}

main "$@"

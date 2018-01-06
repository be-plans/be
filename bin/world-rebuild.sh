#! /usr/bin/env bash

# Run this script outside a studio environment, from "be"(project) root directory

main() {
  if [ ! -e "bin/build-base-plans.sh" ]; then
    echo "Please execute the script from the project root directory"
    exit 1
  fi

  hab studio rm
  hab studio new
  hab studio run 'hab pkg install be/bash'
  hab studio run 'hab pkg install be/coreutils'
  hab studio run 'hab pkg install be/file'
  hab studio run 'hab pkg binlink --dest /bin be/bash'
  hab studio run 'hab pkg binlink --dest /usr/bin be/coreutils'
  hab studio run 'hab pkg binlink --dest /usr/bin be/file'
  hab studio run 'ln -s /src /be'
  hab studio run 'cd / && /be/bin/build-base-plans.sh'
}

main "$@"

#! /usr/bin/env bash

# Run this script outside a studio environment, from "be"(project) root directory

main() {
  if [ ! -e "bin/build-base-plans.sh" ]; then
    echo "Please execute the script from the project root directory"
    exit 1
  fi

  hab studio rm
  hab studio new
  hab studio run 'hab pkg install lilian/bash'
  hab studio run 'hab pkg binlink --dest /bin lilian/bash'
  hab studio run 'ln -s /src /be'
  hab studio run 'cd / && /be/bin/build-base-plans.sh'
}

main "$@"

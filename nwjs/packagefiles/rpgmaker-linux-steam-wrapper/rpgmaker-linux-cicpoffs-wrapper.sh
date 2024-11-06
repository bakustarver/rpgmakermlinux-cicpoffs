#!/bin/bash

if [[ ! -z "${LD_PRELOAD}" ]]; then
     echo "LD_PRELOAD found with $LD_PRELOAD"
     export ORIGINAL_LD_PRELOAD="$LD_PRELOAD"
     export LD_PRELOAD=""
#      export PATH=""
fi
export LD_LIBRARY_PATH=""

#
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ $2 == *"iscriptevaluator.exe"* ]]; then
  echo "ignoring iscriptevaluator.exe"
  exit 0
fi

if [ -z "$SteamAppId" ]; then
  echo "no steam app id"
  exit 0
fi
export LC_ALL=""
startset=$(echo "$@" | sed -e 's@waitforexitandrun @@g' -e 's@ --in-process-gpu@@g')
export gamef=$(dirname "$startset")

xdg-open "rpgmakermp:///$gamef"

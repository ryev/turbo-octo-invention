#!/usr/bin/env bash
SCRIPT_NAME=$( basename --  "${BASH_SOURCE[0]}" )

if [ $# -lt 2 ]; then
  echo "Usage: $SCRIPT_NAME <container id/name> <conda env name>"
  exit 1
fi

CONTAINER=$1
CONDA_ENV=$2
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
START_MIDDLEWARE="cd $SCRIPT_DIR && bash run-1-servers-container.sh $1"
osascript -e 'tell app "Terminal" to do script '"\"$START_MIDDLEWARE\""

for i in {1..30}; do 
  sleep 1
  if  [ exec 6<>/dev/tcp/127.0.0.1/80 ]; then
    exec 6>&-     # close output
    exec 6<&-     # close input
    break
  fi
done


cd $SCRIPT_DIR && bash run-2-browser-viz.sh

START_CAMERA="cd $SCRIPT_DIR && conda activate $2 && bash run-3-camera.sh"
osascript -e 'tell app "Terminal" to do script '"\"$START_CAMERA\""



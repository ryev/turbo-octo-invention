#!/usr/bin/env bash
SCRIPT_NAME=$( basename --  "${BASH_SOURCE[0]}" )

if [ $# -lt 1 ]; then
  echo "Usage: $SCRIPT_NAME <container id/name>"
  exit 1
fi

CONTAINER=$1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker run --rm -p 80:80 -p 6379:6379 -p 3000:3000 -v $SCRIPT_DIR/../WebGL-Fluid-Simulation:/usr/share/nginx/html/static $CONTAINER


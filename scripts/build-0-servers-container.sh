#!/usr/bin/env bash
SCRIPT_NAME=$( basename --  "${BASH_SOURCE[0]}" )

if [ $# -lt 1 ]; then
  echo "Usage: $SCRIPT_NAME <container id/name>"
  exit 1
fi

CONTAINER=$1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/../containers/simple && docker build -t $CONTAINER .



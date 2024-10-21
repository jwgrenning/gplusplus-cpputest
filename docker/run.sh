#!/bin/bash

TAG=jwgrenning/wingman-build
if [[ "$1" != "" ]]; then
  TAG=$TAG-$1
fi

HOST_WORKDIR=${PWD}
WORKDIR=/home
COMMAND=${2:-/bin/bash}

sudo docker run \
  --rm \
  --name wingman-build \
  --volume "${HOST_WORKDIR}":"${WORKDIR}" \
  --workdir "${WORKDIR}" \
  -it $TAG \
  $COMMAND


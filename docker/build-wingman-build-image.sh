#!/bin/bash
TAG=jwgrenning/wingman-build
if [[ "$1" != "" ]]; then
	TAG=$TAG-$1
fi
# DOCKER_HUB_USER_ID=jwgrenning
echo Building $TAG

time sudo docker build -f Dockerfile-wingman-build \
		--tag $TAG \
		. 2>&1 | tee docker-build.log
#spd-say "Docker ---  build --- is --- done --- ${TAG}"
#	$(dirname $0)/_run_help.sh
echo "Now you can:"
echo sudo docker push ${TAG}

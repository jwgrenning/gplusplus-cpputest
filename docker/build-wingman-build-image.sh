#!/bin/bash
TAG=jwgrenning/wingman-build
#TAG=jwgrenning/wingman-gcc-x
if [[ "$1" != "" ]]; then
	TAG=$TAG-$1
fi
time sudo docker build -f Dockerfile-wingman-build \
		--tag $TAG \
		. 2>&1 | tee docker-build.log
#spd-say "Docker ---  build --- is --- done --- ${TAG}"
#	$(dirname $0)/_run_help.sh
echo "Now you can:"
echo sudo docker push ${TAG}

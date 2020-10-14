#!/bin/bash -Eeu

apk add --no-cache gcc g++ musl-dev make
apk add --no-cache autoconf automake git libtool

cd /

wget https://github.com/cpputest/cpputest/releases/download/latest-passing-build/cpputest-latest.tar.gz
tar -xf ./cpputest-latest.tar.gz
rm ./cpputest-latest.tar.gz
mv cpputest-latest cpputest

cd cpputest/
autoreconf . -i
./configure
make

apk del git

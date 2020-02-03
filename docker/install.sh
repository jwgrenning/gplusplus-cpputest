#!/bin/bash -Eeu

apt-get install --yes \
    autoconf \
    automake \
    git \
    libtool

cd /
git clone https://github.com/cpputest/cpputest.git
cd cpputest/
autoreconf . -i
./configure
make
apt-get remove --yes git

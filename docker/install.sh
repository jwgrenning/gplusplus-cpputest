#!/bin/bash

src_install()
{
  apt-get update
  cd /
  apt-get install --yes git
  git clone https://github.com/cpputest/cpputest.git
  apt-get remove  --yes git

  apt-get install --yes autoconf automake git libtool
  cd cpputest/
  autoreconf . -i
  ./configure
  make
}

src_install

#!/bin/bash

src_install()
{
  apt-get update
  cd /
  apt-get install --yes git
  git clone https://github.com/cpputest/cpputest.git
  apt-get remove  --yes git

  apt-get install --yes autoconf automake git libtool
  cd cpputest
  ./autogen.sh # This is giving errors about missing file ./ltmain.sh
  mkdir a_build_dir
  cd a_build_dir
  ../configure
  make
  make check
}

src_install

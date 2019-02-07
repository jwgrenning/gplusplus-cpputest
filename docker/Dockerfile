FROM cyberdojofoundation/gplusplus
LABEL maintainer=jon@jaggersoft.com

RUN \
apt-get update && \
apt-get install --yes \
    autoconf \
    automake \
    git \
    libtool && \
\
cd / && \
git clone https://github.com/cpputest/cpputest.git && \
cd cpputest/ && \
autoreconf . -i && \
./configure && \
make && \
apt-get remove --yes git

COPY red_amber_green.rb /usr/local/bin

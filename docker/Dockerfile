FROM       cyberdojofoundation/gplusplus:7.1
MAINTAINER Jon Jagger <jon@jaggersoft.com>

RUN apt-get update
RUN apt-get install -y automake autoconf libtool

WORKDIR /
RUN git clone https://github.com/cpputest/cpputest.git

WORKDIR cpputest/cpputest_build
RUN autoreconf .. -i
RUN ../configure
RUN make

WORKDIR /
RUN chown -R www-data cpputest
RUN chgrp -R www-data cpputest

COPY red_amber_green.rb /usr/local/bin

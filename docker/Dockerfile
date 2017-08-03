FROM  cyberdojofoundation/gplusplus:7.1
LABEL maintainer=jon@jaggersoft.com

RUN apt-get update
RUN apt-get install --yes automake autoconf libtool git

WORKDIR /
RUN git clone https://github.com/cpputest/cpputest.git

WORKDIR cpputest/
RUN autoreconf . -i
RUN ./configure
RUN make

WORKDIR /
RUN chown -R www-data cpputest
RUN chgrp -R www-data cpputest

COPY red_amber_green.rb /usr/local/bin

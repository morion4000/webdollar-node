FROM ubuntu:16.04

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y linuxbrew-wrapper clang wget software-properties-common cmake libtool autoconf psmisc opencl-headers ocl-icd-libopencl1 pciutils
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs

ENV NODE_TLS_REJECT_UNAUTHORIZED=0

RUN git clone https://github.com/WebDollar/Node-WebDollar.git
RUN cp -R Node-WebDollar/* .

RUN npm install

RUN git clone https://github.com/WebDollar/argon2
WORKDIR /usr/src/app/argon2
RUN autoreconf -i
RUN bash configure
RUN cmake -DCMAKE_BUILD_TYPE=Release .
RUN make
WORKDIR /usr/src/app
RUN cp -a argon2/* dist_bundle/CPU/

ADD start_pool_mining.sh .
ADD start_mining.sh .

CMD [ "sh", "start_pool_mining.sh" ]

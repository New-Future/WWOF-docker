FROM alpine:3.4
MAINTAINER New Future <docker@newfuture.cc>

LABEL Name="WWOF-docker" Description="This image is used to start node with supervisor"

#https://github.com/mhart/alpine-node/blob/master/Dockerfile

ENV BUILD_DEPS="curl make gcc g++ python linux-headers paxctl libgcc libstdc++ gnupg" \
    NODE_VERSION=v6.6.0 \
    NODE_CONFIG_FLAGS="--fully-static" \
    NODE_ALIAS_PATH="/usr/local/bin/node" \
    NODE_PATH="/usr/lib/node_modules" \
    GYP_DEFINES="linux_use_gold_flags=0" \
    NPM_PACKAGE="supervisor ws"

#install nodejs
RUN apk add --no-cache --virtual build-dependencies ${BUILD_DEPS} &&\
  curl -sSL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz | tar -zx && \
  cd node-${NODE_VERSION} && \
  ./configure --prefix=/usr ${NODE_CONFIG_FLAGS} && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make -j${NPROC} -C out mksnapshot BUILDTYPE=Release && \
  paxctl -cm out/Release/mksnapshot && \
  make -j${NPROC} && \
  make install && \
  paxctl -cm /usr/bin/node && \
  npm install -g ${NPM_PACKAGE} && \
  npm cache clean && \
  echo '#!/bin/sh'>$NODE_ALIAS_PATH && \
  echo "export NODE_PATH=\${NODE_PATH-'$NODE_PATH'}">>$NODE_ALIAS_PATH && \
  echo '/usr/bin/node $@'>>$NODE_ALIAS_PATH && \
  chmod +x $NODE_ALIAS_PATH && \
  find /usr/lib/node_modules/ -name test -o -name .bin -type d | xargs rm -rf && \
  find /usr/lib/node_modules/ -name *.md -type f | xargs rm -f && \
  apk del build-dependencies && \
  rm -rf /etc/ssl  /node-${NODE_VERSION} "/usr/include" \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /root/.gnupg \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html


WORKDIR /newfuture/wwof

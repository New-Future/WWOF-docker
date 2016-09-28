FROM mhart/alpine-node
MAINTAINER New Future <docker@newfuture.cc>

LABEL Description="This image is used to start node with supervisor"

WORKDIR "/data/wwof"

ADD ["package.json", "./"]

RUN apk add --no-cache --virtual make gcc g++ python && \
    npm install && \
    npm install supervisor -g && \
    npm cache clean && \
    apk del make gcc g++ python


EXPOSE 8888

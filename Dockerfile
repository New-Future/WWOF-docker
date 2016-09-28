FROM mhart/alpine-node
MAINTAINER New Future <docker@newfuture.cc>

LABEL Description="This image is used to start node with supervisor"

WORKDIR "/newfuture/wwof"

ADD ["package.json", "./"]

RUN apk add --no-cache python make gcc g++ && \
    npm install && \
    npm install supervisor -g && \
    npm cache clean && \
    apk del make gcc g++ python


EXPOSE 8888

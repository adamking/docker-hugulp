FROM node:10-alpine

# update and install tools
RUN apk update
RUN apk upgrade
RUN apk add --update git make bash hugo
RUN npm i -g npm

# install hugulp build dependencies
RUN apk add --update g++ libsass autoconf nasm automake

ADD . /site
WORKDIR /site

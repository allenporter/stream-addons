# syntax=docker/dockerfile:1
# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Example build command from add-on root directory:
# $ docker build --build-arg BUILD_FROM="homeassistant/amd64-base:latest" --build-arg "BUILD_ARCH=amd64" --build-arg TEMPIO_VERSION=2021.09.0 -t rtsp-to-webrtc rtsp-to-webrtc

ARG BUILD_FROM
ARG GO_VERSION=1.16

##
## Prepare
##
FROM golang:${GO_VERSION} as prepare

ARG REPO=github.com/deepch/RTSPtoWebRTC

RUN apt-get install git

WORKDIR /build/$REPO

RUN git clone --depth 1 https://$REPO .
RUN go get
RUN go mod download
RUN CGO_ENABLED=0 go build -a -o /app/rtsp-to-webrtc
RUN cp -rp web /app

##
## Deploy
##

# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
FROM $BUILD_FROM
ARG TEMPIO_VERSION
ARG BUILD_ARCH

WORKDIR /app

# Execute during the build of the image
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

# Copy root filesystem
COPY rootfs /

ENV GO111MODULE="on"
ENV GIN_MODE="release"
COPY --from=prepare /app /app

EXPOSE 8083

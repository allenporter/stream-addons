# syntax=docker/dockerfile:1
# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile

ARG BUILD_FROM
ARG GO_VERSION=1.16

##
## Prepare
##
FROM golang:${GO_VERSION} as prepare

ARG REPO=github.com/deepch/RTSPtoWebRTC

RUN apt-get install git

RUN git clone --depth 1 https://$REPO /app/$REPO

WORKDIR /app/$REPO

RUN go get
RUN go mod download
RUN CGO_ENABLED=0 go build -a -o /app/rtsp-to-webrtc

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

COPY --from=prepare /app/rtsp-to-webrtc .

EXPOSE 8083

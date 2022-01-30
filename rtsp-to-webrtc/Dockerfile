# syntax=docker/dockerfile:1
# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
#
# Example build command from add-on root directory:
# $ docker build --build-arg BUILD_FROM="homeassistant/amd64-base:latest" --build-arg "BUILD_ARCH=amd64" --build-arg TEMPIO_VERSION=2021.09.0 -t rtsp-to-webrtc rtsp-to-webrtc

ARG BUILD_FROM
FROM $BUILD_FROM
ARG BUILD_ARCH
ARG TEMPIO_VERSION=2021.09.0

RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN apk add go git

ARG REPO=github.com/deepch/RTSPtoWebRTC
WORKDIR /build/$REPO
RUN git clone --depth 1 https://$REPO .

RUN go get
RUN go mod download
RUN CGO_ENABLED=0 go build -a -o /app/rtsp-to-webrtc
RUN cp -rp web /app
RUN chmod +x /app/rtsp-to-webrtc

WORKDIR /app

# Copy root filesystem
COPY rootfs /

ENV GO111MODULE="on"
ENV GIN_MODE="release"

EXPOSE 8083

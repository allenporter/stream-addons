# syntax=docker/dockerfile:1
#
# Example build command from add-on root directory:
# $ docker build --build-arg BUILD_FROM="homeassistant/amd64-base:latest" --build-arg "BUILD_ARCH=amd64" --build-arg TEMPIO_VERSION=2021.09.0 -t rtsp-to-web rtsp-to-web

ARG BUILD_FROM

# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
FROM $BUILD_FROM
ARG TEMPIO_VERSION=2021.09.0
ARG BUILD_ARCH

# Execute during the build of the image
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"


RUN apk add go git

ARG REPO=github.com/deepch/RTSPtoWeb
WORKDIR /build/$REPO

RUN git clone https://$REPO .
RUN git fetch
RUN git reset --hard "64289619ffa24d99ca3e0537fe37f2660cb79cf6"

# Apply local patches
COPY *.patch .
RUN for i in *.patch; do \
    git apply "${i}"; done

RUN go get
RUN go mod download
RUN CGO_ENABLED=0 go build -a -o /app/rtsp-to-web
RUN cp -rp web /app
RUN chmod +x /app/rtsp-to-web

WORKDIR /app

# Copy root filesystem
COPY rootfs /

ENV GO111MODULE="on"
ENV GIN_MODE="release"

EXPOSE 8083

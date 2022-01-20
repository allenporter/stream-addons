# syntax=docker/dockerfile:1
#
# Example build command from add-on root directory:
# $ docker build --build-arg BUILD_FROM="homeassistant/amd64-base:latest" --build-arg "BUILD_ARCH=amd64" --build-arg TEMPIO_VERSION=2021.09.0 -t rtsp-to-web rtsp-to-web

ARG BUILD_FROM
ARG GO_VERSION=1.16

##
## Prepare
##
FROM golang:${GO_VERSION} as prepare

ARG REPO=github.com/deepch/RTSPtoWeb

RUN apt-get install git

WORKDIR /build/$REPO

RUN git clone https://$REPO .

RUN go get
RUN go mod download
RUN CGO_ENABLED=0 go build -a -o /app/rtsp-to-web
RUN cp -rp web /app

##
## Deploy
##

# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
FROM $BUILD_FROM
ARG TEMPIO_VERSION=2021.09.0
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
RUN chmod +x /app/rtsp-to-web

EXPOSE 8083

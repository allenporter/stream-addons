# syntax=docker/dockerfile:1
#
# Example build command from add-on root directory:
# $ docker build --build-arg BUILD_FROM="homeassistant/amd64-base:latest" --build-arg "BUILD_ARCH=amd64" --build-arg TEMPIO_VERSION=2021.09.0 -t rtsp-to-web rtsp-to-web

# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:11.0.1


FROM golang:1.17.6-alpine3.15 AS build

RUN apk add --no-cache git

# Clone repo
ARG REPO="deepch/RTSPtoWeb"
WORKDIR /workspace
RUN \
    git clone https://github.com/$REPO . \
    && git reset --hard "64289619ffa24d99ca3e0537fe37f2660cb79cf6"

# Apply local patches
COPY *.patch .
RUN git apply -- *.patch

# Build
ENV GO111MODULE="on"
ENV GIN_MODE="release"
ENV CGO_ENABLED="0"
RUN \
    go get \
    && go mod download \
    && go build -a -o ./rtsp-to-web


FROM scratch AS rootfs

COPY rootfs /
COPY --from=build /workspace/web /app/web
COPY --from=build /workspace/rtsp-to-web /app/rtsp-to-web


FROM $BUILD_FROM

# Copy root filesystem
COPY --from=rootfs / /

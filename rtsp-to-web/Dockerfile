# syntax=docker/dockerfile:1
#
# Example build command from add-on root directory:
# $ docker build --tag rtsp-to-web rtsp-to-web

# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_ARCH="amd64"
ARG BUILD_FROM="ghcr.io/hassio-addons/base/${BUILD_ARCH}:11.0.1"

ARG GO111MODULE="on"
ARG GIN_MODE="release"


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
ARG GO111MODULE
ARG GIN_MODE
ARG CGO_ENABLED="0"
RUN \
    go get \
    && go mod download \
    && go build -a -o ./rtsp-to-web


FROM scratch AS rootfs

COPY rootfs /
COPY --from=build /workspace/web /app/web
COPY --from=build /workspace/rtsp-to-web /app/rtsp-to-web


FROM ${BUILD_FROM}

ARG GO111MODULE
ARG GIN_MODE
ENV GO111MODULE="${GO111MODULE}"
ENV GIN_MODE="${GIN_MODE}"

# Copy root filesystem
COPY --from=rootfs / /

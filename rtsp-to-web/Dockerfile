# syntax=docker/dockerfile:1
#
# Example build command from add-on root directory:
# $ docker build --tag rtsp-to-web rtsp-to-web

# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_ARCH="amd64"
ARG BUILD_FROM="ghcr.io/home-assistant/${BUILD_ARCH}-base:latest"

FROM ${BUILD_FROM} AS build

RUN apk add --no-cache git go

# Clone repo
ARG RTSPTOWEB_REPO="deepch/RTSPtoWeb"
ARG RTSPTOWEB_VERSION="latest"
WORKDIR /workspace
RUN git clone -b $RTSPTOWEB_VERSION https://github.com/$RTSPTOWEB_REPO .


# Build
ENV GO111MODULE="on"
ENV CGO_ENABLED="0"
RUN \
    go get \
    && go mod download \
    && go build -a -o ./rtsp-to-web


FROM scratch AS rootfs

COPY rootfs /
COPY --from=build /workspace/web /app/web
COPY --from=build /workspace/rtsp-to-web /app/rtsp-to-web


FROM ${BUILD_FROM}

ENV GIN_MODE="release"

# Copy root filesystem
COPY --from=rootfs / /

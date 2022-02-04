#!/usr/bin/with-contenv bashio
#
# Creates initial RTSPtoWeb confiugration

readonly CONF='/data/config.json'

debug=$(hass.config.get 'debug')
log_level=$(hass.config.get 'log_level')
http_port=$(hass.config.get 'http_port')
rtsp_port=$(hass.config.get 'rtsp_port')

sed -i "s/%%debug%%/${debug}/g" /data/config.json
sed -i "s/%%log_level%%/${log_levelt}/g" /data/config.json
sed -i "s/%%http_port%%/${http_port}/g" /data/config.json
sed -i "s/%%rtsp_port%%/${rtsp_port}/g" /data/config.json

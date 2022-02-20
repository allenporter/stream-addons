# Home Assistant Add-on: RTSPtoWeb - WebRTC

## How to use

This add-on runs a standalone [RTSPtoWeb](https://github.com/deepch/RTSPtoWeb) server that proxies RTSP streams as WebRTC, and other streaming protocols. To work in Home Assistant, you also need to configure the *RTSPtoWebRTC* [integration](https://www.home-assistant.io/integrations/rtsp_to_webrtc/) which should automatically discover this service.

See the [installation video](https://www.youtube.com/watch?v=6hJXenSZJ5M) for a walkthrough of these steps:

1. You should already have a camera configured with an existing Home Assistant integration, and have it working e.g.  using a lovelace card like *Picture glance card* set to *live*, or the standard entity card. *Note: Low Latency HLS (LL-HLS) is enabled by default in Home Assitant and may be sufficient for your needs. If so, no need to install this Add-on.*

1. Install this add-on and start the server

1. Navigate to the integration page in Home Assistant: *Configuration > Devices & Services > Integrations*.

1. The integration should discover the add-on server automatically, making it configurable with one click. If not, then click *Add Integration* and search for *RTSPtoWeb* and tou will need to enter the url and host:port for this add-on.

1. Load your camera, and they should automatically be using WebRTC with near instant latency.

See the [integration page](https://www.home-assistant.io/integrations/rtsp_to_webrtc/) for more details how this works in Home Assistant. See the [RTSPtoWeb github page](https://www.home-assistant.io/integrations/rtsp_to_webrtc/) for more
information on the project.

## Networking & Security

RTSPtoWeb is a server that opens a port to the local network. The server exposes all available streams and does not require authentication. You should only use this Add-on if you are comfortable with the security implications.

## Troubleshooting

The add-on and integration may not work for your particular setup, and Home Assistant cannot support and troubleshoot user problems that are unrelated to the actual integration in Home Assistant.

The WebRTC stream negotiation process and streaming can very a lot depending on your network setup and camera setup. *RTSPtoWebRTC* supports specific audio and video codecs only, see [Limitations](https://github.com/deepch/RTSPtoWeb#limitations)

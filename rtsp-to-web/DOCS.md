# Home Assistant Add-on: RTSPtoWeb

## How to use

This add-on is a standalone server that proxies RTSP streams as WebRTC, and other streaming protocols. To work in Home Assistant, you also need to configure the *RTSPtoWebRTC* integration.

See https://www.home-assistant.io/integrations/rtsp_to_webrtc/ for details on the integration and how it works in Home Assistant.

## Networking & Security

RTSPtoWeb is a server that opens a port to the local network. The server exposes all available streams and does not require authentication.

## Troubleshooting

The integration may not work for your particular setup, and Home Assistant cannot support and troubleshoot user problems that are unrelated to the actual integration in Home Assistant.

The WebRTC stream negotiation process and streaming can very a lot depending on your network setup and camera setup. *RTSPtoWebRTC* supports specific audio and video codecs only, see [Limitations](https://github.com/deepch/RTSPtoWeb#limitations)


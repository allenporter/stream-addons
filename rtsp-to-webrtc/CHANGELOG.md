<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

## 0.0.7

- Additional fixes for initial development and testing
- Fix nil map error due to missing "streams" in config.json

## 0.0.6

- Fixes for health checks to get initial container working end-to-end

## 0.0.5

- Expose on host network for initial testing
- Simplify configuration, no longer using ingress for initial testing

## 0.0.4

- Publish discovery messages with host:port
- Run on the host network for testing WebRTC protocol
- Build docker images using github build process and multiple architectures

## 0.0.3

- Use docker image build for RTSPtoWebRTC
- Removed unnecessary preferences
- Update logo to WebRTC logo
- Initial skeleton

# Container image that runs your code
FROM alpine:3.17
ENV CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN apk add bash
RUN bash
RUN apk add g++ gcc make
RUN apk add cmake autoconf automake build-base
RUN apk add libcap libpcap-dev
RUN apk add python3
RUN python3 -m ensurepip --upgrade
RUN apk add git
RUN apk add python3-dev libffi-dev libftdi1-dev bzip2-dev openssl-dev cargo jpeg-dev zlib-dev ffmpeg-dev
RUN pip3 install aiohttp
RUN pip3 install ffmpeg
RUN pip3 install libpcap
RUN pip3 install tzdata
RUN pip3 install PyNaCl
RUN pip3 install Pillow
RUN pip3 install git+https://github.com/boto/botocore
RUN pip3 install homeassistant

# Set the working directory
VOLUME /config
# Expose the Home Assistant port (8123)
EXPOSE 8123
# Start Home Assistant
CMD ["hass --config /config"]


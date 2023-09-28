# Container image that runs your code
FROM alpine:3.17
ENV CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN apk add bash
RUN bash
RUN apk add g++ gcc make 
RUN apk add libcap libpcap-dev
RUN apk add ffmpeg-dev python3-dev sqlite-dev libffi-dev libftdi1-dev bzip2-dev openssl-dev jpeg-dev zlib-dev
RUN apk add git cargo build-base
RUN mkdir /config

# Download, extract, configure, compile, and install Python 3.11
RUN wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz && \
    tar -xzf Python-3.11.0.tgz && \
    cd Python-3.11.0 && \
    ./configure --enable-optimizations --with-openssl-rpath=auto && \
    make -j 4 && \
    make install

RUN python3 -m ensurepip --upgrade
# RUN pip3 install --upgrade pip
RUN pip3 install aiohttp
RUN pip3 install ffmpeg
RUN pip3 install libpcap
RUN pip3 install tzdata
RUN pip3 install PyNaCl
RUN pip3 install Pillow
RUN pip3 install git+https://github.com/boto/botocore
RUN pip3 install homeassistant


# Set the volume directory
VOLUME /config
# Expose the Home Assistant port (8123)
EXPOSE 8123
# Start Home Assistant
CMD ["hass", "--config", "/config"]


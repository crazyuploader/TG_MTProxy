#
# Created by Jugal Kishore - 2024
#
# Using Ubuntu:18.04 as Base Image
FROM ubuntu:18.04 AS builder

# Install required package(s)
RUN apt-get update && \
    apt-get install --yes git \
    curl build-essential libssl-dev \
    zlib1g-dev

# Set Working directory
WORKDIR /app

# Clone MTProxy Repository from: https://github.com/TelegramMessenger/MTProxy
RUN git clone https://github.com/TelegramMessenger/MTProxy mtproxy

# Set working directory for building
WORKDIR /app/mtproxy

# Build MTProxy
RUN make

# Use environment variable for secret and config paths
ENV PROXY_SECRET_FILE=/app/config/proxy-secret
ENV PROXY_CONFIG_FILE=/app/config/proxy-multi.conf

# Expose Ports
EXPOSE 443
EXPOSE 8888

# Set Entry point
CMD "/app/mtproxy/objs/bin/mtproto-proxy" -u nobody -p 8888 -H 443 -S $SECRET --aes-pwd $PROXY_SECRET_FILE $PROXY_CONFIG_FILE -M 1 --http-stats

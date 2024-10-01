#!/usr/bin/env bash

# Get Proxy Configuration & Proxy Secret from Telegram
curl -s https://core.telegram.org/getProxySecret -o config/proxy-secret 
curl -s https://core.telegram.org/getProxyConfig -o config/proxy-multi.conf

SECRET=$(head -c 16 /dev/urandom | xxd -ps)
echo "SECRET=$SECRET" > .env

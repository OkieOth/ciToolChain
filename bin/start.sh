#!/bin/bash

scriptPos=${0%/*}

absPathToBase=$(pushd $scriptPos/.. > /dev/null; pwd ; popd > /dev/null)

composeFile="$scriptPos/../docker-compose.yml"

if ! [ -d "$scriptPos/../proxy/logs" ]; then mkdir -p "$scriptPos/../proxy/logs"; fi
if ! [ -d "$scriptPos/../nexus/data" ]; then mkdir -p "$scriptPos/../nexus/data"; chmod -R 777 "$scriptPos/../nexus/data"; fi

# create new self-signed certificate if needed
# better solution is to work with own CA and copy cert
# to $scriptPos/../proxy/ssl/nginx.crt
if ! [ -f $scriptPos/../proxy/ssl/nginx.key ]; then
    pushd $scriptPos/../proxy/ssl > /dev/null
    openssl req -x509 -config cert_config.txt -nodes -days 730 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
    popd > /dev/null
fi


proxyContName=cit_proxy_0.1

docker ps -f name="$proxyContName" | grep "$proxyContName" > /dev/null && echo -en "\033[1;31m  container seems to be up: $proxyContName\033[0m\n" && exit 1


if docker ps -a -f name="$proxyContName" | grep "$proxyContName" > /dev/null; then
    docker-compose -f "$composeFile" start
else
    docker-compose -f "$composeFile" up -d
fi


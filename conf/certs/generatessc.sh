#!/bin/bash
# From https://gist.github.com/scottvrosenthal/5691305
openssl genrsa 2048 > wildcard.key
openssl req -new -x509 -nodes -sha1 -days 3650 -key wildcard.key > wildcard.crt
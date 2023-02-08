#!/bin/bash
set -ex

nginx
rm -rf /usr/share/nginx/html/index.html
gcsfuse test-nginx /data && touch /data/111.txt
cp -p /data/test.html /usr/share/nginx/html/index.html
chmod 755 /usr/share/nginx/html/index.html
nginx -s reload

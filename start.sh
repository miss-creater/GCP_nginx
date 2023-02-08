#!/bin/bash
set -ex

nginx
mkdir /data
rm -rf /usr/share/nginx/html/index.html
gcsfuse test-nginx /data && chmod 777 /data && cp -p /data/test.html /usr/share/nginx/html/index.html
chmod 755 /usr/share/nginx/html/index.html
nginx -s reload

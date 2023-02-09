#!/bin/bash
set -ex
mkdir /data
rm -rf /usr/share/nginx/html/index.html
gcsfuse test-nginx /data && chmod 777 /data && cp -p /data/test1.html /usr/share/nginx/html/index.html
chmod 755 /usr/share/nginx/html/index.html
nginx -g "daemon off;"

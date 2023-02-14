#!/bin/bash
set -ex
mkdir /data
rm -rf /usr/share/nginx/html/index.html
gcsfuse test-nginx /data && chmod 777 /data && cp -p /data/test.html /usr/share/nginx/html/index.html
touch /tmp/111.txt
chmod 755 /usr/share/nginx/html/index.html
nginx -g "daemon off;"

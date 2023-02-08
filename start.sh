#!/bin/bash
set -ex

nginx
mkdir /data
rm -rf /usr/share/nginx/html/index.html
gcsfuse test-nginx /data && sudo cp -p /data/test.html /usr/share/nginx/html/index.html
sudo chmod 755 /usr/share/nginx/html/index.html
nginx -s reload

#!/bin/bash
set -ex 
rm -rf /usr/share/nginx/html/index.html
nohup gcsfuse test-nginx /data &
touch /data/111.txt
cp -p /data/test.html /usr/share/nginx/html/index.html
nginx

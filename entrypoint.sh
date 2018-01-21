# !/bin/sh

sed -e "/ listen / s/80/$PORT/" -i /etc/nginx/conf.d/default.conf
envsubst '$PORT' < /etc/nginx/conf.d/mkdocs.conf > /etc/nginx/conf.d/mkdocs.conf

nginx -g 'daemon off;'

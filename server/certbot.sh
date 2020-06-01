#!/usr/bin/env bash
echo "Args: <domain> <email>"

echo "Starting nginx ..."
docker-compose up --force-recreate -d nginx
echo

docker run -it --rm \
  -v /etc/letsencrypt:/etc/letsencrypt \
  -v /var/www/certbot:/var/www/certbot \
  certbot/certbot \
  certonly --webroot -w /var/www/certbot --email $2 --agree-tos --non-interactive -d $1

echo "Please uncomment SSL section in nginx.conf."
echo "Then run \
    docker-compose up --force-recreate -d nginx"
echo "Then you can run docker-compose up."

.PHONY: validate

validate:
	docker run --rm -t -a stdout --name validator \
		-v ${PWD}/nginx:/etc/nginx:ro \
		-v /etc/letsencrypt:/etc/letsencrypt:ro \
		nginx:latest nginx -c /etc/nginx/nginx.conf -t

restart: validate
	docker-compose down --remove-orphans && docker-compose up -d

logs:
	docker-compose logs

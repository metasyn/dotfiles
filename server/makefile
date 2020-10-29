.PHONY: validate
.ONESHELL:

validate:
	docker run --rm -t -a stdout --name validator \
		-v ${PWD}/nginx:/etc/nginx:ro \
		-v /etc/letsencrypt:/etc/letsencrypt:ro \
		nginx:latest nginx -c /etc/nginx/nginx.conf -t

ttrss:
	cd ttrs; docker-compose up --build

restart: validate
	docker-compose restart nginx

logs:
	docker-compose logs -f

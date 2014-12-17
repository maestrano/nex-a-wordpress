=======
Nex! Wordpress Application
===============

	````
	docker run -d \
		--name wordpress-db \
		-v /home/cesar/poc/dockerization/storage/db/data:/var/lib/mysql \
		-e MYSQL_ROOT_PASSWORD=maestradmin \
		mysql:5.5
	````

	````sleep 2````

	````
	docker run -p 49207:80 -d --privileged=true \
		--name wordpress-app \
		-v /home/cesar/poc/dockerization/storage:/storage \
		--link=wordpress-db:mysql \
		maestrano/a-wordpress
	````
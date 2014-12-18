=======
Nex! Wordpress Application
===============

* Run MySQL container

    ````bash
    docker run -d \
    	--name wordpress-db \
    	-v /home/cesar/poc/dockerization/storage/db/data:/var/lib/mysql \
    	-e MYSQL_ROOT_PASSWORD=maestradmin \
    	mysql:5.5
    ````

* Wait a bit for it to start

    ````bash
    sleep 2
    ````

* Run Nex! Wordpress application container with a link to the MySQL container above

    ````bash
    docker run -p 49207:80 -d --privileged=true \
    	--name wordpress-app \
    	-v /home/cesar/poc/dockerization/storage:/storage \
    	--link=wordpress-db:mysql \
    	maestrano/a-wordpress
    ````
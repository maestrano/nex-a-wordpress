# Maestrano Wordpress application

FROM maestrano/s-phpmysql

MAINTAINER Cesar Tonnoir <it@maestrano.com>

# Copy chef files
RUN touch /var/log/chef/a-install.log
COPY mno/chef/a-install-config.rb /mno/chef/
COPY mno/chef/a-install-attributes.json /mno/chef/

# Install cookbooks
RUN git clone https://github.com/maestrano/nex-cookbook-wordpress.git /mno/chef/cache/cookbooks/wordpress
RUN berks install -b /mno/chef/cache/cookbooks/wordpress/Berksfile
RUN berks package -b /mno/chef/cache/cookbooks/wordpress/Berksfile /mno/chef/cookbook-wordpress.tar.gz

# Run chef to configure php-fpm, nginx, etc, and install wordpress
RUN chef-solo -c /mno/chef/a-install-config.rb && \
	rm /mno/chef/cookbook-wordpress.tar.gz

# Copy run script & chef files
RUN touch /var/log/chef/a-run.log
COPY mno/chef/a-run-config.rb /mno/chef/
COPY mno/chef/a-run-attributes.json /mno/chef/
COPY mno/scripts/run.sh /mno/scripts/
RUN chmod +x /mno/scripts/run.sh

ENTRYPOINT ["/mno/scripts/run.sh"]
EXPOSE 80
CMD nginx
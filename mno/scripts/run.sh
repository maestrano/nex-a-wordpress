#!/bin/bash

rm -rf /storage/app/var
mkdir -p /storage/app/var
mv /var/log /storage/app/var
rm -rf /var/log
ln -s /storage/app/var/log /var

# Run chef solo for db linking
chef-solo -c /mno/chef/a-run-config.rb	

mkdir -p /storage/app/src
mount -t overlayfs -o upperdir=/storage/app/src,lowerdir=/app/src overlayfs /app/src_runtime

#Debug
printenv

service php5-fpm restart

# If no other command is passed, nginx will run in the foreground
exec "$@"
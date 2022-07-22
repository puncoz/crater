#! /bin/sh

if [ ! -d /.composer ]; then
    mkdir /.composer
fi

chmod -R ugo+rw /.composer

supervisord -c /etc/supervisord.conf
exec php-fpm

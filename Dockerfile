# PHP 7.2 
# Phalcon
# xdebug

FROM php:7.2-apache-stretch

# redis-5.0.3
RUN pecl install redis-4.2.0; \
    pecl install xdebug-2.6.1; \
    docker-php-ext-enable redis xdebug

#  && /usr/local/bin/apt-install \
#        php7.2-dev \
#        php7.2-common \
#        php7.2-cli
RUN apt-get clean -y; \
    apt-get update; \
    apt-get install -y wget; \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg; \
    echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list; \
    apt-get purge -y wget; \    
    apt-get full-upgrade -y; \
    apt-get autoremove -y; \
    apt-get autoclean -y; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN a2enmod rewrite

RUN touch /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20170718/xdebug.so\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_enable = 1\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_autostart = 1\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_handler = dbgp\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_port = 9000\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_host = localhost\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_mode = req\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.profiler_output_dir = tmp\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.output_buffering = 0\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_connect_back = 1\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini
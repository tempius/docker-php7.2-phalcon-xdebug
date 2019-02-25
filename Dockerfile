# PHP 7.2 
# Phalcon
# xdebug

FROM php:7.2-alpine

# PHP
RUN pecl install redis-4.1.1; \
    pecl install xdebug-2.6.1; \
    pecl install apcu-5.1.16; \
    pecl install psr-0.6.0; \
    docker-php-ext-enable redis xdebug apcu psr #json soap pdo_mysql pdo mysqli mbstring curl bcmath; \
    a2enmod rewrite

# phalcon
RUN apt-get update; \
    apt-get install -y git; \
    cd /usr/local/lib/php/extensions; \
    git clone https://github.com/phalcon/cphalcon; \
    cd cphalcon/build; \
    ./install --phpize /usr/local/bin/phpize --php-config /usr/local/bin/php-config; \
    apt-get purge -y git; \
    apt-get autoremove -y; \
    apt-get autoclean -y; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/local/lib/php/extensions/cphalcon; \
    touch /usr/local/etc/php/conf.d/30-phalcon.ini; \
    printf "extension=/usr/local/lib/php/extensions/no-debug-non-zts-20170718/phalcon.so\n" >> /usr/local/etc/php/conf.d/30-phalcon.ini
    
# x-debug
RUN touch /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_enable = 1\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_autostart = 1\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_handler = dbgp\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_port = 9000\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_host = localhost\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_mode = req\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.profiler_output_dir = tmp\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.output_buffering = 0\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini; \
    printf "xdebug.remote_connect_back = 1\n" >> /usr/local/etc/php/conf.d/20-xdebug.ini

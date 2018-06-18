FROM debian:stretch-slim

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
            apt-transport-https gnupg ca-certificates curl bash \
    && echo "deb https://packages.sury.org/php/ stretch main" >> /etc/apt/sources.list.d/sury.org.list \
    && curl -sS https://packages.sury.org/php/apt.gpg | apt-key add - \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
            php7.2-fpm \
    && apt-get purge --autoremove -y gnupg \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/* /tmp/* \
    && mkdir /run/php

COPY www.conf /etc/php/7.2/fpm/pool.d/

EXPOSE 9000

CMD ["php-fpm7.2"]

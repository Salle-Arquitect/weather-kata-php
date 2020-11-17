ARG VERSION
#FROM composer:$VERSION
FROM php:$VERSION-cli

ARG user
ARG group
ARG uid
ARG gid
ARG USER_HOME=/home/$user

RUN groupadd -g $gid $group \
 && useradd -d $USER_HOME -u $uid -g $gid -m -s /bin/bash $user

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
 && php composer-setup.php \
    --install-dir=/usr/local/bin \
    --filename=composer
RUN apt-get update -y \
 && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    git \
 && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-configure gd \
 && docker-php-ext-install -j$(nproc) gd

ENV PATH=$PATH:/home/$user/src/vendor/bin

#WORKDIR $USER_HOME/src/
#COPY composer.json .
#RUN composer install
#USER $user:$group

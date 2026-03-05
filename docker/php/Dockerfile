FROM php:7.4-apache

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    curl \
    git \
    unzip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install \
        gd \
        intl \
        mysqli \
        pdo \
        pdo_mysql \
        xsl \
        zip \
        opcache

# Installation de Composer via l'installeur officiel
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite

# Création de l'utilisateur ezpublish
RUN useradd -m -s /bin/bash ezpublish \
    && usermod -a -G www-data ezpublish \
    && echo "ezpublish ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini
COPY docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf

COPY docker/php/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]

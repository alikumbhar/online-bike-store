
# CodeIgniter 3 bike shop — PHP 8.2 + Apache
FROM php:8.2-apache

ENV DEBIAN_FRONTEND=noninteractive

# Install system packages required by Composer ZIP downloads
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        unzip \
        libzip-dev \
    && docker-php-ext-install zip mysqli pdo pdo_mysql \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Install framework dependencies first for layer caching
COPY composer.json ./

RUN composer install \
    --no-dev \
    --no-interaction \
    --no-progress \
    --no-scripts \
    --prefer-dist

# Copy application code
COPY . /var/www/html

# Ensure CodeIgniter cache and logs are writable
RUN mkdir -p application/cache application/logs \
    && chown -R www-data:www-data application/cache application/logs \
    && chmod -R 775 application/cache application/logs

# Document root: project root containing index.php and system/
EXPOSE 80

FROM php:8.1-fpm

# Install system dependencies and common PHP extensions for web development
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    mysqli \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache \
    && docker-php-ext-enable mysqli pdo_mysql opcache \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
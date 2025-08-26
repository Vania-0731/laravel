# Usa la imagen oficial de PHP con FPM (FastCGI Process Manager)
FROM php:8.1-fpm

# Instala herramientas y extensiones necesarias para Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    zip \
    && docker-php-ext-install zip pdo pdo_mysql

# Instala Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /var/www/html

# Copia todos los archivos del proyecto al contenedor
COPY . .

# Instala las dependencias de PHP con Composer
RUN composer install --no-dev --optimize-autoloader

# Expone el puerto 9000 que usa PHP-FPM
EXPOSE 9000

# Comando para iniciar PHP-FPM cuando el contenedor se ejecute
CMD ["php-fpm"]

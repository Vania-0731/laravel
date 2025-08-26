FROM php:8.1-fpm
# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    zip \
    libpq-dev \
    libonig-dev \
    libxml2-dev \
    curl \
    && docker-php-ext-install pdo pdo_pgsql mbstring zip exif pcntl

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia archivos del proyecto
COPY . .

# Instala las dependencias
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Abre el puerto
EXPOSE 9000

# Comando por defecto
CMD ["php-fpm"]

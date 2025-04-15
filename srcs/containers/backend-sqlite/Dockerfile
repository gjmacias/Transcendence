# Definir variables de entorno para la versión de PHP
ARG PHP_VERSION=8.2
# Usamos PHP con FPM (FastCGI Process Manager)
FROM		php:${PHP_VERSION}-fpm

# Instalamos extensiones necesarias para SQLite
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite

WORKDIR /var/www/html

# Copiamos script inicio
COPY		./tools/entrypoint.sh	./entrypoint.sh
# Copiamos el archivo php.ini personalizado para producción
COPY		./conf/php.ini /usr/local/etc/php/
# Copiar el archivo www.conf personalizado para PHP-FPM
COPY		./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

# Permisos y punto de entrada
RUN			chmod +x ./entrypoint.sh

# Exponemos el puerto que PHP-FPM usará para aceptar conexiones
EXPOSE		9000

# Entrypoint para iniciar y cargar DB si hace falta
ENTRYPOINT ["bash", "./entrypoint.sh"]

# Comando para iniciar PHP-FPM en primer plano
CMD			["php-fpm${PHP_VERSION}", "-F"]

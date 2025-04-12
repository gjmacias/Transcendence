#!/bin/bash

cd /var/www/html

# Descomprimir la base de datos BBDD.tar si no existe
if [ ! -f "${NAME}.sqlite" ]; then
  echo "Descomprimiendo base de datos..."
  tar -xvf BBDD.tar -C .
fi

# Establecer permisos correctos en los archivos y carpetas importantes
echo "Estableciendo permisos..."
chmod -R 755 .
chmod 600 ${NAME}.sqlite

exec "$@"
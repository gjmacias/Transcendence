FROM node:18-alpine

# Instalamos dependencias necesarias
RUN apk add --no-cache \
    bash \
    curl \
    git \
    python3 \
    py3-pip \
    && python3 -m venv /venv  
	# Crear entorno virtual

# Install Avalanche Node (AVAX) and blockchain tools

# Crear directorio de trabajo
WORKDIR /app

# Exponemos el puerto necesario para Avalanche
EXPOSE 9650

# Script para correr el nodo Avalanche en el contenedor
ENTRYPOINT ["/bin/bash", "-c", "avalanchego --network-id=local --http-port=9650 --staking-port=9651"]

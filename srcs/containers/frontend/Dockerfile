# Imagen base liviana con Node.js
FROM node:18-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar package.json y package-lock.json primero para aprovechar la caché de Docker
COPY ./conf/package*.json ./

# Instalar dependencias
RUN npm install -D tailwindcss typescript

COPY ./conf ./

# Generar el archivo de configuración de Tailwind si no existe (por si lo quieres hacer desde Docker)
# RUN npx tailwindcss init

# Puerto donde corre el frontend
EXPOSE 3000

# Comando por defecto
CMD ["npm", "start"]

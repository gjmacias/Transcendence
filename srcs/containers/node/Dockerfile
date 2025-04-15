FROM node:18-alpine

WORKDIR /app

# Copiamos primero los archivos necesarios para instalar dependencias
COPY ./conf/package*.json ./
RUN npm install

# Copiamos el resto del código
COPY ./conf ./

# Compilamos el TypeScript
RUN npm run build

EXPOSE 4000

CMD ["npm", "start"]

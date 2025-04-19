FROM node:18-alpine

WORKDIR /app

# Copiamos package.json y tsconfig.json
COPY package*.json ./
COPY tsconfig.json ./

# Instalamos dependencias
RUN npm install

RUN npm install typescript -g


# Copiamos el resto del código
COPY src ./src

# Compilamos el TypeScript
RUN npm run build || cat /app/src/index.ts

EXPOSE 4000

CMD ["npm", "start"]

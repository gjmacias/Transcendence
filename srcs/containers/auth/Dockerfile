FROM node:18-alpine

WORKDIR /usr/src/app

COPY data/package*.json ./
RUN npm install

COPY data .

EXPOSE 3000

CMD [ "node", "main.js"]
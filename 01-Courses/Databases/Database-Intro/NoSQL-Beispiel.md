Hier ist eine `docker-compose.yaml`-Datei, die Redis und MongoDB Server sowie deren Verwaltungsoberflächen startet, zusammen mit einer einfachen Node.js-Beispielanwendung, die beide Datenbanken verwendet:

```yaml
version: '3.9'

services:
  mongodb:
    image: mongo:latest
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db

  mongo-express:
    image: mongo-express
    ports:
      - "8081:8081"
    environment:
      - ME_CONFIG_MONGODB_SERVER=mongodb
    depends_on:
      - mongodb

  redis:
    image: redis:latest
    ports:
      - "6379:6379"

  redis-commander:
    image: rediscommander/redis-commander:latest
    ports:
      - "8082:8081"
    environment:
      - REDIS_HOSTS=local:redis:6379
    depends_on:
      - redis

  example-app:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - mongodb
      - redis
    environment:
      - MONGODB_URI=mongodb://mongodb:27017/exampledb
      - REDIS_URL=redis://redis:6379

volumes:
  mongo_data:
```

Für die Beispielanwendung erstellen Sie ein `Dockerfile` im gleichen Verzeichnis:

```dockerfile
FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
```

Und hier ist ein einfaches `app.js` für die Beispielanwendung:

```javascript
const express = require('express');
const mongoose = require('mongoose');
const redis = require('redis');
const { promisify } = require('util');

const app = express();
const port = 3000;

// MongoDB Verbindung
mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });

// Redis Verbindung
const redisClient = redis.createClient(process.env.REDIS_URL);
const getAsync = promisify(redisClient.get).bind(redisClient);
const setAsync = promisify(redisClient.set).bind(redisClient);

app.get('/', async (req, res) => {
  // Redis Beispiel
  await setAsync('visits', parseInt(await getAsync('visits') || 0) + 1);
  const visits = await getAsync('visits');

  // MongoDB Beispiel
  const Test = mongoose.model('Test', new mongoose.Schema({ name: String }));
  await Test.create({ name: 'test' });
  const count = await Test.countDocuments();

  res.send(`Hello! Redis visits: ${visits}, MongoDB documents: ${count}`);
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
```

Um die Anwendung zu starten, führen Sie folgende Schritte aus:

- Erstellen Sie eine `package.json`-Datei mit den notwendigen Abhängigkeiten (express, mongoose, redis).

```json
{
  "name": "redis-mongodb-example",
  "version": "1.0.0",
  "description": "Example application using Redis and MongoDB",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.17.1",
    "mongoose": "^5.13.7",
    "redis": "^3.1.2"
  }
}
```

- Führen Sie `docker-compose up --build` aus.

Die Verwaltungsoberflächen sind dann unter folgenden URLs erreichbar:
- Mongo Express: http://localhost:8081
- Redis Commander: http://localhost:8082

Die Beispielanwendung läuft auf http://localhost:3000 und demonstriert die Verwendung beider Datenbanken[1][2][4].

Citations:
[1] https://blog.devops.dev/docker-compose-setup-for-mongodb-redis-and-minio-f364e79162ea?gi=71f800b91c37
[2] https://dev.to/ifeanyichima/build-nodejs-api-with-redis-mongodb-in-docker-51e0
[3] https://github.com/techiall/docker-mysql-mongo-redis
[4] https://dev.to/renacargnelutti/node-js-rest-api-with-docker-redis-and-mongodb-3p7c
[5] https://dev.to/truongpx396/quickly-start-dev-environment-for-mysql-postgresql-mongodb-redis-and-kafka-using-docker-compose-40p9
[6] https://github.com/hsadler/docker-flask-mysql-mongodb-redis-sample
[7] https://www.codecentric.de/wissens-hub/blog/microservice-deployment-ganz-einfach-mit-docker-compose
[8] http://www.philipermish.com/blog/docker-example-with-nginx-node-redis-mongodb-and-jekyll/
# task1 : Docker file with security best practices

# use minimal image 
FROM node:18-slim

WORKDIR /app

COPY package*.json ./

# use audit, cache for clean the vulnerable packages
RUN npm ci --only=production && npm audit fix && npm cache clean --force

COPY . .

RUN addgroup --system --gid 1001 appgroup && adduser --system --uid 1001 --ingroup appgroup appuser

#change ownership to only app can access the current files and folder

RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 3000

# set env variables

ENV NODE_ENV=production

CMD ["node","server.js"]





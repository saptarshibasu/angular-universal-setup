FROM keymetrics/pm2:8-alpine
COPY aus/dist /usr/local/dist
WORKDIR /usr/local
ENTRYPOINT ["pm2-runtime","start","/usr/local/dist/server.js"]

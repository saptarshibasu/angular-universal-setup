FROM node:8.10.0 AS ausbuilder
RUN useradd --create-home --shell /bin/bash aus; \
    chown -R aus /home/aus
USER aus
WORKDIR /home/aus
COPY aus/ /home/aus
RUN mkdir /home/aus/.npm; \
    npm config set prefix /home/aus/.npm; \
    npm install --quiet --no-progress -g webpack@3.11.0; \
    npm install --quiet --no-progress -g @angular/cli@1.7.2; \
	npm install --quiet --no-progress;
ENV PATH=/home/aus/.npm/bin:$PATH
RUN	npm run build; \
	webpack --config webpack.server.config.js --no-progress

FROM keymetrics/pm2:8-alpine
RUN adduser -h /home/aus -s /bin/bash aus; \
    chown -R aus /home/aus
USER aus
WORKDIR /home/aus
COPY --from=ausbuilder /home/aus/dist /home/aus/dist
EXPOSE 4000/tcp
ENTRYPOINT ["pm2-runtime","start","/home/aus/dist/server.js"]

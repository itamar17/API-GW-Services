FROM node:18.12.1-alpine3.16
LABEL PrometheusScrapping=true
RUN apk add bash git python3 make tini && npm i -g typescript
ENV NODE_ENV=dev
USER node
RUN npm config set scripts-prepend-node-path true
COPY --chown=node:node yarn.lock /opt/services/video-service/
COPY --chown=node:node package.json /opt/services/video-service/
WORKDIR /opt/services/video-service
RUN yarn install --production=false --frozen-lockfile
COPY  --chown=node:node *.json *.ts /opt/services/video-service/
COPY  --chown=node:node src/ /opt/services/video-service/src/
RUN yarn build && yarn cache clean
ENTRYPOINT ["/sbin/tini",  "-g", "--", "npm", "run", "start"]

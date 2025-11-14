FROM node:25.2.0-alpine3.21@sha256:fabc70f280a2929c4644df04697cdc31cee87615087df3a329bd0e003b0c1d2c

WORKDIR /app

COPY notion-export.js package.json package-lock.json ./

RUN npm install

ENV NOTION_TOKEN="" \
    NOTION_FILE_TOKEN="" \
    NOTION_BLOCK_ID="" \
    OUTPUT_DIR=""

CMD [ "npm", "run", "start" ]
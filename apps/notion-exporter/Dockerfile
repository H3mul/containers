FROM node:25.1.0-alpine3.21@sha256:afcd03e0c9ae83fc30d48c8f05de72938e116d83b58b8220debfd0f56aff67ae

WORKDIR /app

COPY notion-export.js package.json package-lock.json ./

RUN npm install

ENV NOTION_TOKEN="" \
    NOTION_FILE_TOKEN="" \
    NOTION_BLOCK_ID="" \
    OUTPUT_DIR=""

CMD [ "npm", "run", "start" ]
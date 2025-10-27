FROM node:25.0.0-alpine3.21

WORKDIR /app

COPY notion-export.js package.json package-lock.json ./

RUN npm install

ENV NOTION_TOKEN="" \
    NOTION_FILE_TOKEN="" \
    NOTION_BLOCK_ID="" \
    OUTPUT_DIR=""

CMD [ "npm", "run", "start" ]
FROM node:25.2.0-alpine3.21@sha256:1f84ac1eb1905acc299971053f2f7efb21f853209f6fe594972a7dd661e76c3b

WORKDIR /app

COPY notion-export.js package.json package-lock.json ./

RUN npm install

ENV NOTION_TOKEN="" \
    NOTION_FILE_TOKEN="" \
    NOTION_BLOCK_ID="" \
    OUTPUT_DIR=""

CMD [ "npm", "run", "start" ]
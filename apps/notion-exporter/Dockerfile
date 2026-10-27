FROM node:25.2.1-alpine3.21@sha256:32509199057d74a987fdd88cde00fdfd48ef52469adbd6bd11969fc701477761

WORKDIR /app

COPY notion-export.ts tsconfig.json package.json package-lock.json ./

RUN npm install && npm run build && npm prune --omit=dev

ENV NOTION_TOKEN="" \
    NOTION_FILE_TOKEN="" \
    NOTION_BLOCK_ID="" \
    OUTPUT_DIR="" \
    DEBUG=""

CMD [ "node", "dist/notion-export.js" ]

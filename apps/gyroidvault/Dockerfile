# syntax=docker/dockerfile:1@sha256:572cebbc2b15e6f84c077742952674889cb63cd5e9b80abdffcbe587b6f19183
#
# GyroidVault, built from the H3mul/GyroidVault fork's `main` branch.
#
# VERSION is the upstream (TeeCodeDev/GyroidVault) release that Renovate tracks in .ci/metadata.yaml. It names the
# image tag; it is not what gets cloned. The source is whatever fork main currently is, so the image only claims a
# release the fork has actually merged (see the guard below).
FROM node:22-alpine@sha256:1314fb30ec37592d5845e5a160d522c0e680972aa534549940b8d73bde88481a

ARG VERSION

WORKDIR /app

# BuildKit resolves the branch to a commit and keys the layer cache on it: a new push to main invalidates this
# layer and everything after it, an unchanged main is a full cache hit.
ADD https://github.com/H3mul/GyroidVault.git#main /app

# Fail rather than publish a tag for a release the fork has not merged yet (fork behind upstream).
# Fork ahead of, or equal to, the tracked release is fine.
RUN node - <<'NODE'
const parse = s => String(s).replace(/^v/, '').split('.').map(n => parseInt(n, 10) || 0);
const code = require('/app/package.json').version, tracked = process.env.VERSION;
const [a, b] = [parse(code), parse(tracked)];
const behind = [0, 1, 2].map(i => (a[i] || 0) - (b[i] || 0)).find(d => d !== 0) < 0;
if (behind) {
  console.error(`fork main is at v${code} but the tracked upstream release is ${tracked}: merge the upstream release into the fork's main, then rebuild`);
  process.exit(1);
}
console.log(`fork main v${code}, tracked upstream release ${tracked}`);
NODE

# All dependencies are pure JS/WASM (sql.js, bcryptjs, occt-import-js): no build toolchain needed.
RUN npm ci --omit=dev && npm cache clean --force \
    && mkdir -p /app/data/uploads

ENV NODE_ENV=production \
    LIBRARY_PATH=/library

EXPOSE 3000
VOLUME ["/app/data"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
    CMD node -e "fetch('http://127.0.0.1:'+(process.env.PORT||3000)+'/healthz').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"

CMD ["node", "server/index.js"]

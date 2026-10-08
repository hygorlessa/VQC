# Stage 1: Build Frontend, Run Type-Check & Unit Tests, and Bundle Backend
FROM node:22-bookworm-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

ARG VITE_FIREBASE_API_KEY="AIzaSyDfD6xMYuChJ3desKvuG_j63ZpW07E-I4s"
ARG VITE_FIREBASE_AUTH_DOMAIN="analise-de-videos-vqc.firebaseapp.com"
ARG VITE_FIREBASE_PROJECT_ID="analise-de-videos-vqc"
ARG VITE_FIREBASE_STORAGE_BUCKET="analise-de-videos-vqc"
ARG VITE_FIREBASE_APP_ID="1:706973594445:web:c9f2cac3bb3de05a183d04"

ENV VITE_FIREBASE_API_KEY=${VITE_FIREBASE_API_KEY}
ENV VITE_FIREBASE_AUTH_DOMAIN=${VITE_FIREBASE_AUTH_DOMAIN}
ENV VITE_FIREBASE_PROJECT_ID=${VITE_FIREBASE_PROJECT_ID}
ENV VITE_FIREBASE_STORAGE_BUCKET=${VITE_FIREBASE_STORAGE_BUCKET}
ENV VITE_FIREBASE_APP_ID=${VITE_FIREBASE_APP_ID}

# Enforce zero-error TypeScript check and full 29-test unit suite (including real ffmpeg/ffprobe check) before production build
RUN npm run lint && npm test && npm run build

# Stage 2: Production Runtime with Real FFmpeg & FFprobe
FROM node:22-bookworm-slim AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080

COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/server.js ./server.js

# Create non-root user for security
RUN groupadd -r vqc && useradd -r -g vqc -m vqc && chown -R vqc:vqc /app
USER vqc

EXPOSE 8080

CMD ["node", "server.js"]

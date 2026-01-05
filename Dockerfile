# =========================
# Base image
# =========================
FROM node:20-alpine AS base
RUN apk add --no-cache libc6-compat
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED=1

# =========================
# Dependencies layer
# =========================
FROM base AS deps
COPY package.json package-lock.json* ./
RUN npm ci

# =========================
# Builder layer
# =========================
FROM base AS builder
WORKDIR /app

# 👇 BUILD-TIME ENV (DUMMY VALUE)
ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build

# =========================
# Runtime layer (ECS)
# =========================
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

RUN addgroup --system --gid 1001 nodejs \
 && adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

# Runtime-required files
COPY --from=builder /app/configs ./configs
COPY --from=builder /app/lib ./lib
COPY --from=builder /app/contexts ./contexts
COPY --from=builder /app/drizzle.config.js ./drizzle.config.js
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules

USER nextjs
EXPOSE 3000

CMD ["node", "server.js"]

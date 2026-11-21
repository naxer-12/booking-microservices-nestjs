# syntax=docker/dockerfile:1
# -------- Builder --------
FROM node:20.19.2-alpine AS builder
WORKDIR /app

# Copy and install building-blocks first
COPY src/building-blocks ./src/building-blocks
WORKDIR /app/src/building-blocks
RUN npm install

# Copy and build passenger
WORKDIR /app
COPY src/passenger ./src/passenger
WORKDIR /app/src/passenger
RUN npm install && npm run build

# -------- Runner --------
FROM node:20.19.2-alpine AS runner
WORKDIR /app

ENV NODE_ENV=docker

# Copy package files first
COPY src/passenger/package*.json ./

# Install only production deps
RUN npm install --omit=dev && npm cache clean --force

# Copy build artifacts
COPY --from=builder /app/src/passenger/dist ./dist

# Copy .env.development to the build folder
COPY --from=builder /app/src/passenger/.env.development ./dist

# Copy building-blocks to node_modules (so it's resolvable)
COPY --from=builder /app/src/building-blocks ./node_modules/building-blocks

EXPOSE 3355
CMD ["node", "dist/main.js"]
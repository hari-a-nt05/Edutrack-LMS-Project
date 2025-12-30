FROM node:20-alpine

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm ci

# Copy app source
COPY . .

# Build Next.js
RUN npm run build

# Expose app port
EXPOSE 3000

# IMPORTANT: Bind to 0.0.0.0
ENV HOST=0.0.0.0
ENV PORT=3000
ENV NODE_ENV=production

# Run Next.js directly (stable)
CMD ["npm", "run", "start"]

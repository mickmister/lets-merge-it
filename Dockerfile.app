# Single-stage build for Node.js/pnpm application
FROM node:20-alpine

# Install pnpm
RUN npm install -g pnpm

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy application source
COPY . .

# Expose the application port
EXPOSE 1340

# Start the application
CMD ["pnpm", "start"]

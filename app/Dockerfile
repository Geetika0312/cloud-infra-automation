FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install --omit=dev

FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=deps /app/node_modules ./node_modules
COPY package.json ./
COPY src ./src

RUN addgroup -g 1001 -S app && adduser -u 1001 -S app -G app
USER 1001

EXPOSE 3000
CMD ["node", "src/index.js"]

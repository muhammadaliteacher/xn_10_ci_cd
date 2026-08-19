FROM node:alpine as builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
ADD . .
RUN npm run build --prod

FROM node:alpine 
WORKDIR /app
COPY --from=builder /app/dist ./dist
ADD package*.json ./
RUN npm ci --omit=dev
CMD [ "node", "./dist/main.js" ]
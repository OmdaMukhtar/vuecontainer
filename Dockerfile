# First Stage
FROM node:22 as builder

WORKDIR /app

COPY package*.json ./
COPY vite.config.js ./
COPY index.html ./

# Copy project files
COPY src/ ./src
RUN npm install \
  && npm run build


# Second Stage
FROM node:22-slim
WORKDIR /vueapp
COPY --from=builder /app .
EXPOSE 8083

CMD ["npm", "run", "dev", "---", "--host", "0.0.0.0", "--port", "8083"]

FROM node:20-slim

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai

WORKDIR /home/user/workspace

EXPOSE 3000

CMD PORT=${PORT:-3000} && opencode web --hostname 0.0.0.0 --port $PORT

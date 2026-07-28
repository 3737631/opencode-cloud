FROM node:20-slim

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai

WORKDIR /home/user/workspace

EXPOSE 8000

CMD opencode web --hostname 0.0.0.0 --port ${PORT:-8000}

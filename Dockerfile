FROM node:20-slim

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai

RUN corepack enable && npm install -g pnpm

WORKDIR /home/user/workspace

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3000

CMD ["/bin/bash", "/start.sh"]

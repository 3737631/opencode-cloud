FROM node:20-slim

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai

WORKDIR /home/user/workspace

EXPOSE 4096

CMD ["opencode", "web", "--hostname", "0.0.0.0", "--port", "4096"]

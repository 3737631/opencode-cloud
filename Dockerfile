FROM node:20-slim
RUN npm install -g opencode-ai
WORKDIR /home/user/workspace
EXPOSE 3000
CMD opencode web --hostname 0.0.0.0 --port ${PORT:-3000}

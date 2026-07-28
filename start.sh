#!/bin/bash
PORT=${PORT:-3000}
OPENCODE_PORT=$((PORT + 1))

# Start OpenCode on the inner port
opencode web --hostname 0.0.0.0 --port $OPENCODE_PORT &

# Start a simple health server on the main port
node -e "
const http = require('http');
const port = $PORT;
const opencodePort = $OPENCODE_PORT;
const server = http.createServer((req, res) => {
  const options = { hostname: '127.0.0.1', port: opencodePort, path: req.url, method: req.method, headers: Object.assign({}, req.headers, { host: '127.0.0.1:' + opencodePort }) };
  const proxy = http.request(options, (proxyRes) => {
    res.writeHead(proxyRes.statusCode, proxyRes.headers);
    proxyRes.pipe(res);
  });
  proxy.on('error', () => {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Starting OpenCode...');
  });
  req.pipe(proxy);
});
server.listen(port, () => console.log('Health server on port ' + port));
"

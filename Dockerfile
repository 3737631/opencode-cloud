FROM node:20-slim

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai

WORKDIR /home/user/workspace

EXPOSE 3000

CMD node -e "
var port = process.env.PORT || 3000;
var opencodePort = port + 1;
require('child_process').spawn('opencode', ['web', '--hostname', '0.0.0.0', '--port', '' + opencodePort], { stdio: 'inherit' });
require('http').createServer(function(req, res) {
  var opts = { hostname: '127.0.0.1', port: opencodePort, path: req.url, method: req.method, headers: req.headers };
  var proxy = require('http').request(opts, function(p) { res.writeHead(p.statusCode, p.headers); p.pipe(res); });
  proxy.on('error', function() { res.writeHead(200, { 'Content-Type': 'text/plain' }); res.end('Starting...'); });
  req.pipe(proxy);
}).listen(port, function() { console.log('OK on ' + port); });
"
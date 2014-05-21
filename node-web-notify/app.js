var  express = require('express')
  ,  http = require('http')
  ,  fs = require('fs')
  ,  redis = require('redis');

var app = express();
var server = app.listen(3000);
var io = require('socket.io').listen(server);

app.configure(function(){
  app.use(express.logger('dev'));
  app.use(express.static(__dirname + '/public'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
});

app.configure('development', function() {
  app.use(express.errorHandler());
});

io.sockets.on('connection', function(socket) {
  const redisClient = redis.createClient();
  redisClient.subscribe('notify-queue');

  redisClient.on("message", function(channel, message) {
    socket.send(message);
  });
});


console.log("Server up and running!");

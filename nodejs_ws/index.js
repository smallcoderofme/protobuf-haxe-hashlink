"use strict";

var {WebSocketServer} = require("ws");
// var WebSocket = require("ws");
var protobuf = require("protobufjs");

const wss = new WebSocketServer({ port: 80 });

wss.on('connection', function connection(ws) {
  ws.on('message', function message(data) {
    console.log('received: %s', data);

    protobuf.load("HelloWorld.proto", function(err, root) {
      var HelloWorld = root.lookupType("lm.HelloWorld");
      var message = HelloWorld.decode(data);
      console.log("message:" + message);
      console.log("message str:" + message["str"]);
      console.log("message id:" + message["id"]);

      var payload = { str: "lisi", id: 18 };
      var message = HelloWorld.create(payload); // or use .fromObject if conversion is necessary

      // Encode a message to an Uint8Array (browser) or Buffer (node)
      var buffer = HelloWorld.encode(message).finish();
      ws.send(buffer);
    });

  });

  // ws.send('send message from server');
});

// const ws = new WebSocket('ws://localhost:8080');

// ws.on('open', function open() {
//   ws.send('something');
// });
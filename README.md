redis-ruby-play
===============

Just playing with redis and ruby. Nothing to see here!

Simple sets: `simple-set.rb`

Pub/sub: `pub.rb`, `sub.rb`

Keyspace pub/sub: `keyspace-pub.rb`, `keyspace-sub.rb`

Simple web client notification using redis, socket.io, and node.js: `node-web-notify`
1. `cd node-web-notify`

2.`npm install`

3. `node app.js`

4. In browser, open up localhost:3000

5. In another term, `redis-cli public notify-fifo hello`

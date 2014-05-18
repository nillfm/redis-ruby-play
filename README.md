redis-ruby-play
===============

Just playing with redis and ruby. Nothing to see here!

Simple sets: `simple-set.rb`

Pub/sub: `pub.rb`, `sub.rb`

Keyspace pub/sub: `keyspace-pub.rb`, `keyspace-sub.rb`

Simple web client notification using redis, socket.io, and node.js: `node-web-notify`
# `cd node-web-notify`
# `npm install`
# `node app.js`
# In browser, open up localhost:3000
# In another term, `redis-cli public notify-fifo hello`

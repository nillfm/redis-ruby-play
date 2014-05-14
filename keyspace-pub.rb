require './common.rb'

@redis = Redis.new
@redis.config 'SET', 'notify-keyspace-events', 'KEA'

for i in 1..1_000
  @redis.set 'my-key' + i.to_s, 'value-' + (i * 1000).to_s
end

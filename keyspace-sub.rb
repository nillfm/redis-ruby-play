require 'redis'

@redis = Redis.new

@redis.psubscribe('__keyspace@0__:my-key*') do |on|
  on.psubscribe do |channel, subs|
    puts "Subscribed to #{channel} #{subs}"
  end
  on.pmessage do |channel, msg|
    puts "got a message -> #{msg}"
  end
end

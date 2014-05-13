require 'redis'
require 'json'

@redis = Redis.new

N = 10_000
NumThreads = 3
threads = []

def simple_pub
  for n in 1..N do
    @redis.publish 'my-channel', {thread: Thread.current.object_id, value: n }.to_json
  end
end

NumThreads.times do |i|
  threads[i] = Thread.new { simple_pub }
end

threads.each { |t| t.join }

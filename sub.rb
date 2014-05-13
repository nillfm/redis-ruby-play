require 'redis'
require 'json'

Redis.new.subscribe('my-channel') do |on|
  on.message do |channel, msg|
    data = JSON.parse(msg)
    puts data
  end
end

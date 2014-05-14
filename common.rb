require 'redis'

def time_op iteration = nil, method = nil
  t1 = Time.now
  send(method, iteration) unless method.nil?
  t2 = Time.now
  @result << { run: method.to_s, timing: t2 - t1 }
  @result.last[:iteration] = iteration unless method.nil?
end

def diagnostics(n)
  i = @redis.info
  puts "(#{n})\t\tused_memory: #{i['used_memory_human']}\t fragmentation: #{i['mem_fragmentation_ratio']}"
end

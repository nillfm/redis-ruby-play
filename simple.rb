require 'redis'

# playing with redis and ruby

N = 1_000
Delta = 100
@redis = Redis.new
@result = []

def time_op iteration, method
	t1 = Time.now
	send(method, iteration)
	t2 = Time.now
	@result << { run: method.to_s, n: iteration, timing: t2 - t1 }
end

def set_test(n)
	for i in 1..n
		@redis.set 'my-key' + i.to_s, 'value-' + (i * 1000).to_s
	end
end

def get_test(n)
	for i in 1..n
		@redis.get 'my-key' + i.to_s
	end
end

def set_test_pipeline(n)
	@redis.pipelined do
		for i in 1..n
			@redis.set 'my-key' + i.to_s, 'value-' + (i * 1000).to_s
		end
	end
end

def get_test_pipeline(n)
	@redis.pipelined do
		for i in 1..n
			@redis.get 'my-key' + i.to_s
		end
	end
end

# def set_test_gen_pipe(n)
# 	buf = ''
# 	for i in 1..n
# 		buf << gen_redis_proto('SET', 'my-key' + i.to_s, i.to_s)
# 	end
# 	buf
# end
#
#
# def gen_redis_proto(*cmd)
# 	gen_cmd = "*#{cmd.length.to_s}\r\n"
# 	cmd.each do |arg|
# 		gen_cmd << "$#{arg.to_s.bytesize}\r\n#{arg.to_s}\r\n"
# 	end
# 	gen_cmd
# end

(1..N).step(Delta) do |n|
	time_op n, :set_test
	time_op n, :get_test
	time_op n, :set_test_pipeline
	time_op n, :get_test_pipeline
	@redis.flushall
end

@result.group_by{|x| x[:run]}.each do |a|
	begin
		file = File.open(a[0] + '.txt', 'w')
		a[1].each{|e| file << "#{e[:n].to_s} #{e[:timing].to_s}\r\n" }
	ensure
		file.close unless file == nil
	end
end

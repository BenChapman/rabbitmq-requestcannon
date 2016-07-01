require_relative './common.rb'

while true do
	exchange.publish("Hello world!", :routing_key => queue.name)
	sleep 0.01
end

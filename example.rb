require 'bunny'
require 'terminal-notifier'

conn = Bunny.new
conn.start

chan = conn.create_channel
queue = chan.queue("cheeses")
exchange = chan.direct('world_of_cheeses')

queue.bind(exchange, :routing_key => 'aged')
exchange.publish("camembert", :routing_key => 'aged')
exchange.publish("roquefort", :routing_key => 'aged')
exchange.publish("american", :routing_key => 'processed')

queue.subscribe(:block => true, :ack => true) do |delivery_info, metadata, payload|
  puts "#{payload}"
  `terminal-notifier -message '#{payload}, a delicious aged cheese'`
  chan.acknowledge(delivery_info.delivery_tag)
end

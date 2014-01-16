#RabbitMQ

####For Greatest Impact!

```
brew install rabbitmq
rabbitmq-server
```

* [Open the local RabbitMQ console](http://localhost:15672/#/channels)
* [Open the Bunny docs](http://rubybunny.info/)

##About RabbitMQ

AMQP is neat

and confusing.

## Things

**AMQP**

Advanced Message Queueing Protocol (an open standard)

**RabbitMQ**

an implementation of AMQP (in Erlang)

**Apache ActiveMQ**

an implementation of AMQP (in Java)


##Some Rabbit terminology
[http://www.rabbitmq.com/tutorials/amqp-concepts.html](http://www.rabbitmq.com/tutorials/amqp-concepts.html)

A **broker**
_is a machine or cluster running the RabbitMQ server_

```
conn = Bunny.new(:hostname => "rabbit.local")
# => #<Bunny::Session:0x007f873ab79dc8>
conn.start
```
A **publisher**
publishes a message to an **exchange**

```
ch = conn.create_channel
q = ch.queue("cheeses")
#<Bunny::Queue:0x007f8739b0fc58>
```

An **exchange** has a type (**direct**, **fanout**, or **topic**) and determines how the routing key is used

```
exchange = ch.direct('world_of_cheeses') 
#=> #<Bunny::Exchange:0x007f8739a24eb0>
```

A **queue** is bound to an **exchange** with a **routing key**

```
queue.bind(exchange, :routing_key => 'aged')
```

Queues, echanges, and bindings are persistent. Future messages published to the exchange will be routed to the queue until the binding is broken.

A **consumer** subscribes to a queue with a routing key.

```
queue.bind(x, :routing_key => 'aged').subscribe do |delivery_info, metadata, payload|
  puts "#{payload} => aaron"
  ch.acknowledge(delivery_info.delivery_tag) # explicit acknowledgement
end
```

## Routing

![](http://www.rabbitmq.com/img/tutorials/intro/hello-world-example-routing.png)

##Types of Exchanges

| type   | use of routing key |
|--------|--------------------|
| fanout | none; all messages are broadcast to all bound queues |
| direct | messages are sent to queues whose routing keys exactly match |
| topic  | similar to direct, but routing keys can include wildcards. |

Consumers specify the kinds of messages they want
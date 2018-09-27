package main

import (
	"fmt"
	"log"
	"time"

	"github.com/golang/protobuf/proto"
	"github.com/mobilityhouse/go-zeta-msgs-bcm"
	"github.com/streadway/amqp"
)

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
		panic(fmt.Sprintf("%s: %s", msg, err))
	}
}

func main() {
	// conn, err := amqp.Dial("amqp://tmh:tmh@localhost:5672/")
	conn, err := amqp.Dial("amqp://admin:stmartinisalsoachildrenssongyo!@0.0.0.0:5672/tmh_controller")
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	exchangeName := "tmh_relay"
	queueName := fmt.Sprintf("barrel.%d", time.Now().UnixNano()/int64(time.Millisecond))

	err = ch.ExchangeDeclare(exchangeName, "topic", false, false, false, false, nil)
	failOnError(err, "Failed to declare a topic exchange")

	queue, err := ch.QueueDeclare(queueName, false, true, true, false, nil)
	failOnError(err, "Failed to declare a queue")

	log.Printf("Binding queue %s to exchange %s with key #", queue.Name, exchangeName)
	err = ch.QueueBind(queue.Name, "BCM001.BCMCORE.*", exchangeName, false, nil)
	failOnError(err, "Failed to bind a queue")

	msgs, err := ch.Consume(queue.Name, "barrel", true, false, false, false, nil)
	failOnError(err, "Failed to register a consumer")

	forever := make(chan bool)

	go func(msg <-chan amqp.Delivery) {
		for {
			log.Print("Looping")
			select {
			case d := <-msg:
				log.Printf("[d.DeliveryTag] %v", d.DeliveryTag)
				log.Printf("[d.ReplyTo] %v", d.ReplyTo)
				log.Printf("[d.RoutingKey] %v", d.RoutingKey)
				if method, ok := d.Headers["method"]; ok {
					log.Printf("[method] %v", method)
					switch method {
					case "AggregatorWriteRequest":
						xz := go_zeta_msgs_bcm.AggregatorWriteRequest{}
						if err := proto.Unmarshal(d.Body, &xz); err != nil {
							log.Fatalln("Failed to parse AggregatorWriteRequest:", err)
							continue
						}
						log.Printf("[AggregatorWriteRequest.FromAggregator.TradedPerPeriodKWh] %v", xz.FromAggregator.TradedPerPeriodKWh)
					case "AggregatorReadRequest":
						xz := go_zeta_msgs_bcm.AggregatorReadRequest{}
						if err := proto.Unmarshal(d.Body, &xz); err != nil {
							log.Fatalln("Failed to parse AggregatorReadRequest:", err)
							continue
						}
						log.Printf("[AggregatorReadRequest] %v", xz)
					case "AmprionWriteRequest":
						xz := go_zeta_msgs_bcm.AmprionWriteRequest{}
						if err := proto.Unmarshal(d.Body, &xz); err != nil {
							log.Fatalln("Failed to parse AmprionWriteRequest:", err)
							continue
						}
						log.Printf("[AmprionWriteRequest] State.Frequency_Hz: %v", xz.State.Frequency_Hz.Value)
					case "GetecWriteRequest":
						xz := go_zeta_msgs_bcm.GetecWriteRequest{}
						if err := proto.Unmarshal(d.Body, &xz); err != nil {
							log.Fatalln("Failed to parse GetecWriteRequest:", err)
							continue
						}
						log.Printf("[GetecWriteRequest] Trading.Soc: %v", xz.Trading.Soc.Value)
					case "GetecReadRequest":
						xz := go_zeta_msgs_bcm.GetecReadRequest{}
						if err := proto.Unmarshal(d.Body, &xz); err != nil {
							log.Fatalln("Failed to parse GetecReadRequest:", err)
							continue
						}
						log.Printf("[GetecReadRequest] %s", xz)
					default:
						log.Printf("ERROR! Unknown method %s", method)
					}
				} else {
					log.Print("Not ok!!!")
					time.Sleep(2 * time.Second)
				}
			}
		}
	}(msgs)

	log.Printf(" [*] Waiting for trading info. To exit press CTRL+C")
	<-forever
}

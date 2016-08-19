package main

import (
	"fmt"
	"net"
)

func main() {
	address := "logstasho.measures.backstage.dev.globoi.com:23456"
	status := "FUCK"
	conn, err := net.Dial("udp", address)
	if err == nil {
		status = "OK"
		defer conn.Close()
	}
	fmt.Println(status)
	udpAddress, err := net.ResolveUDPAddr("udp", address)
	udpConn, err := net.DialUDP("udp", nil, udpAddress)
	if err == nil {
		status = "OK"
		defer udpConn.Close()
	}
	fmt.Println(status)
}

package main

import (
	"fmt"
	"os"

	"github.com/golang/protobuf/proto"
	"github.com/mobilityhouse/go-zeta-msg-bcm"
)

func main() {
	xz := go_zeta_msg_bcm.AggregatorWriteRequest{}
	out, err := proto.Marshal(&xz)
	if err != nil {
		fmt.Errorf("Failed to encode address book: %s", err)
		os.Exit(1)
	}
	fmt.Println("Hello, playground:", xz.From)
	fmt.Println("Hello, playground:", out)
}

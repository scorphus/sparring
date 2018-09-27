package main

import (
	"encoding/binary"
	"fmt"
	"math/rand"
	"time"
)

func main() {
	rand.Seed(time.Now().UTC().UnixNano())
	m := rand.Intn(500000) - 250000
	fmt.Printf("%v\n", m)
	m32 := uint32(m)
	fmt.Printf("%v\n", m32)
	mByteArray := make([]byte, 4)
	binary.BigEndian.PutUint32(mByteArray, m32)
	fmt.Printf("%v\n", mByteArray)
	n32 := binary.BigEndian.Uint32(mByteArray)
	fmt.Printf("%v\n", n32)
	n := int32(n32)
	fmt.Printf("%v\n", n)
}

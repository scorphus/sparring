package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, playground")
	byte_arra := [][]byte{[]byte("ls -lhart /etc")}
	fmt.Printf("%v\n", byte_arra)
	fmt.Printf("%v\n", string(byte_arra[0]))
}

func (cc commandCount) Len() int {
	return len(cc.command)
}
func (cc commandCount) Swap(i, j int) {
	cc[i], cc[j] = cc[j], cc[i]
}
func (cc commandCount) Less(i, j int) bool {
	return cc[i].frequency < cc[j].frequency
}

package main

import (
	"flag"
	"fmt"
)

var N = flag.Int("n", 1_000_000, "slice size")

func withoutMake(n int) []int {
	var s []int
	for i := range n {
		s = append(s, i)
	}
	return s
}

func withMake(n int) []int {
	s := make([]int, 0, n)
	for i := range n {
		s = append(s, i)
	}
	return s
}

func main() {
	// usage: go run . -n 1000 (default: 1_000_000)
	flag.Parse()
	fmt.Printf("withoutMake: len=%d cap=%d\n", len(withoutMake(*N)), cap(withoutMake(*N)))
	fmt.Printf("withMake:    len=%d cap=%d\n", len(withMake(*N)), cap(withMake(*N)))
}

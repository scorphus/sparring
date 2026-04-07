package main

import "fmt"

// const N = 100
// const N = 1_000
const N = 1_000_000

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
	fmt.Printf("withoutMake: len=%d cap=%d\n", len(withoutMake(N)), cap(withoutMake(N)))
	fmt.Printf("withMake:    len=%d cap=%d\n", len(withMake(N)), cap(withMake(N)))
}

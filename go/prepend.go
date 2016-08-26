package main

import "fmt"

func main() {
	data := []string{"A", "B", "C", "D"}
	data = append([]string{"Prepend Item"}, data...)
	fmt.Println(data)
	// [Prepend Item A B C D]
}

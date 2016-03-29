package main

import (
	"github.com/scorphus/measures"
)

var M = measures.New("measures-example", "0.0.0.0:3593")

func countExample() {
	M.Count("fruits", 1, measures.Dimensions{"name": "avocado"})
}

func main() {
	countExample()
	M.CleanUp()
}

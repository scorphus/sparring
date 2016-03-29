package main

import (
	"fmt"

	"github.com/scorphus/measures"
)

var M = measures.New("measures-example", "logstash.measures.backstage.dev.globoi.com:3593")

func countExample() {
	err := M.Count("fruits", 1, measures.Dimensions{"name": "avocado"})
	fmt.Println(err)
}

func main() {
	countExample()
	M.CleanUp()
}

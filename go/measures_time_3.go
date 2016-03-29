package main

import (
	"time"

	"github.com/scorphus/measures"
)

var M = measures.New("measures-example", "0.0.0.0:3593")

func timeExample() {
	d := make(measures.Dimensions, 2)
	defer M.Time("example", time.Now(), d)
	// do some lengthy operation
	time.Sleep(359e6)
	d["number"] = 359
	d["isPrime"] = true
}

func main() {
	timeExample()
	M.CleanUp()
}

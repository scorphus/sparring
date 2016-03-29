package main

import (
	"time"

	"github.com/scorphus/measures"
)

var M = measures.New("measures-example", "0.0.0.0:3593")

func timeExample() {
	defer M.Time("example", time.Now(), measures.Dimensions{"number": 359})
	// do some lengthy operation
	time.Sleep(359)
}

func main() {
	timeExample()
	M.CleanUp()
}

package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println(time.Now().UnixNano(), "time.Now().UnixNano()")
	fmt.Println(time.Now().UnixNano()/int64(time.Millisecond), "time.Now().UnixNano() / int64(time.Millisecond)")
	fmt.Println(time.Now().UnixNano()/int64(time.Second), "time.Now().UnixNano() / int64(time.Second)")
	fmt.Println(time.Now().Unix(), "time.Now().Unix()")
}

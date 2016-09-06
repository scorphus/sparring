package main

import (
	"fmt"
	"net/http"
	"net/url"
	"os"
	"strconv"
	s "strings"
	"time"

	"github.com/franela/goreq"
)

func main() {
	args := os.Args[1:]
	uri := args[0]
	qs := url.Values{}
	for _, val := range args[1:] {
		parts := s.Split(val, "=")
		fmt.Printf("%q\n", parts)
		qs.Set(parts[0], parts[1])
	}
	timeout, _ := strconv.Atoi(os.Getenv("TIMEOUT"))
	showDebug, _ := strconv.ParseBool(os.Getenv("SHOWDEBUG"))
	fmt.Println("timeout is:", timeout, time.Duration(timeout)*time.Millisecond)
	fmt.Println("showDebug is:", showDebug)
	res, err := goreq.Request{
		Uri:         uri,
		QueryString: qs,
		Timeout:     time.Duration(timeout) * time.Millisecond,
		ShowDebug:   showDebug,
	}.Do()
	if err != nil {
		fmt.Printf("Request error: %s", err)
		os.Exit(5)
	}
	if res.StatusCode != http.StatusOK {
		body, _ := res.Body.ToString()
		fmt.Printf("Request fail: %d - %s", res.StatusCode, body)
		os.Exit(5)
	}
	var o interface{}
	res.Body.FromJsonTo(&o)
	for k, v := range o.(map[string]interface{}) {
		fmt.Printf("%s: %s\n", k, v)
	}
}

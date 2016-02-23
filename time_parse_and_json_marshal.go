package main

import (
	"encoding/json"
	"fmt"
	"time"
)

type SomeStruct struct {
	AnyString      string    `json:"anyString"`
	SomeTime       time.Time `json:"someTime"`
	YetAnotherBool bool      `json:"yetAnotherBool,omitempty"`
	TimeDelta      uint64    `json:"timeDelta,omitempty"`
}

func (s SomeStruct) MarshalJSON() ([]byte, error) {
	type t SomeStruct
	s_ := t(s)
	s_.TimeDelta = uint64(time.Since(s.SomeTime).Seconds())
	return json.Marshal(s_)
}

func main() {
	layout := "2006-01-02T15:04:05.000Z"
	timeStr := "1816-02-23T22:19:19.019Z"
	timeTime, _ := time.Parse(layout, timeStr)
	s := SomeStruct{
		AnyString:      "AnyString",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
}

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
	TimeDelta      int64     `json:"timeDelta,omitempty"`
}

func (s SomeStruct) MarshalJSON() ([]byte, error) {
	type t SomeStruct
	s_ := t(s)
	s_.TimeDelta = int64(time.Since(s.SomeTime).Seconds())
	return json.Marshal(s_)
}

func main() {
	time := time.Now().AddDate(0, 0, -1)
	s := SomeStruct{
		AnyString:      "AnyString",
		SomeTime:       time,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
}

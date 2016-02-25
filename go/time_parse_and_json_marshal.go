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

func round1() {
	layout := "2006-01-02T15:04:05.000Z"
	timeStr := "1816-02-23T22:19:19.019Z"
	timeTime, err := time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error", err.Error())
	}
	s := SomeStruct{
		AnyString:      "AnyString1",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
}

func round2() {
	layout := "2006-01-02T15:04:05.000000000Z"
	timeStr := "2016-02-03T16:34:18.430153915Z"
	timeTime, err := time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error", err.Error())
	}
	s := SomeStruct{
		AnyString:      "AnyString2",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
}

func round3() {
	layout := "2006-01-02T15:04:05.000Z"
	timeStr := "2011-06-12T15:38:15.678Z"
	timeTime, err := time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error", err.Error())
	}
	s := SomeStruct{
		AnyString:      "AnyString3",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
}

func main() {
	round1()
	round2()
	round3()
}

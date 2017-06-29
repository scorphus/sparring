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
		fmt.Println("Fuck! Error with round1", err.Error())
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
		fmt.Println("Fuck! Error with round2", err.Error())
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
	layout := "2006-01-02T15:04:05.00000000Z"
	timeStr := "2017-04-22T13:45:51.09554977Z"
	timeTime, err := time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error with round3", err.Error())
	}
	s := SomeStruct{
		AnyString:      "AnyString2",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
}

func round4() {
	layout := "2006-01-02T15:04:05.000000000Z"
	timeStr := "2017-04-22T13:45:51.195500000Z"
	timeTime, err := time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error with round3", err.Error())
	}
	s := SomeStruct{
		AnyString:      "AnyString2",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
}

func round5() {
	layout := "2006-01-02T15:04:05.000Z"
	timeStr := "2011-06-12T15:38:15.678Z"
	timeTime, err := time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error with round5", err.Error())
	}
	s := SomeStruct{
		AnyString:      "AnyString3",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
}

func round6() {
	layout := "2006-01-02T15:04:05.000Z"
	timeStr := "2017-01-26T02:20:01.649Z"
	timeTime, err := time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error with round6.1", err.Error())
	}
	s := SomeStruct{
		AnyString:      "AnyString3",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ := json.Marshal(s)
	fmt.Println(string(content))
	timeStr = "2017-01-26T02:19:53.468Z"
	timeTime, err = time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error with round6.2", err.Error())
	}
	s = SomeStruct{
		AnyString:      "AnyString3",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ = json.Marshal(s)
	fmt.Println(string(content))
	timeStr = "2017-01-26T02:19:42.888Z"
	timeTime, err = time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error with round6.3", err.Error())
	}
	s = SomeStruct{
		AnyString:      "AnyString3",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ = json.Marshal(s)
	fmt.Println(string(content))
	timeStr = "2017-01-26T02:19:37.280Z"
	timeTime, err = time.Parse(layout, timeStr)
	if err != nil {
		fmt.Println("Fuck! Error with round6.4", err.Error())
	}
	s = SomeStruct{
		AnyString:      "AnyString3",
		SomeTime:       timeTime,
		YetAnotherBool: true,
	}
	content, _ = json.Marshal(s)
	fmt.Println(string(content))
}

func main() {
	round1()
	round2()
	round3()
	round4()
	round5()
	round6()
}

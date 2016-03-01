package main

import (
	"encoding/json"
	"fmt"
)

type SomeStruct struct {
	ABool     bool   `json:"aBool,omitempty"`
	AnInt     int64  `json:"anInt,omitempty"`
	AnyString string `json:"anyString,omitempty"`
}

func main() {
	jsonContent := `[]`
	var SomeList []SomeStruct
	err := json.Unmarshal([]byte(jsonContent), &SomeList)
	if err != nil {
		fmt.Printf("%+v", err)
	} else {
		fmt.Printf("%+v", SomeList)
	}
}
